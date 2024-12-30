import os
import json
import spotipy
import requests
import threading
import subprocess
from functools import partial
from mutagen.easyid3 import EasyID3
from mutagen.id3 import ID3, APIC, error
from spotipy.oauth2 import SpotifyClientCredentials

import gi
from gi.repository import GLib



def on_download_button_clicked(parent_window, config_file, youtube_link_entry, spotify_link_entry, button):
    youtube_link_entry_text = youtube_link_entry.get_text()
    spotify_link_entry_text = spotify_link_entry.get_text()

    parent_window.textbuffer.delete(parent_window.textbuffer.get_start_iter(), parent_window.textbuffer.get_end_iter())

    if youtube_link_entry_text == "":
        parent_window.textbuffer.insert_at_cursor('ERROR: No youtube link entered!')
        return

    if spotify_link_entry_text == "":
        parent_window.textbuffer.insert_at_cursor('INFO: No spotify link entered!\n')

    with open(config_file, 'r') as f:
        try:
            cfg = json.load(f)
            client_id = cfg.get('spotify_client_id', "")
        except:
            client_id = ""

    with open(config_file, 'r') as f:
        try:
            cfg = json.load(f)
            client_secret = cfg.get('spotify_client_secret', "")
        except:
            client_secret = ""

    with open(config_file, 'r') as f:
        try:
            cfg = json.load(f)
            folder_path = cfg.get('folder_path', "")
        except:
            folder_path = ""

    if folder_path == "":
        parent_window.textbuffer.insert_at_cursor('WARN: No download path set! Defaulting to Download folder\n')
        folder_path = os.path.join(os.environ.get('HOME'), 'Downloads')

    if not client_id == "" and not client_secret == "" and not spotify_link_entry_text == "":
        try:
            parent_window.textbuffer.insert_at_cursor('INFO: Fetching song metadata...\n\n')

            client_credentials_manager = SpotifyClientCredentials(client_id=client_id, client_secret=client_secret)
            sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)

            items = sp.track(track_id=spotify_link_entry_text)
            track_name = items.get("name")
            album_info = items.get("album")
            track_artist = ", ".join([artist["name"] for artist in items["artists"]])

            if album_info:
                track_album = album_info.get("name")
                track_year = (
                    album_info.get("release_date")[:4]
                    if album_info.get("release_date")
                    else ""
                )
                album_total = album_info.get("total_tracks")
            
            track_num = items["track_number"]
            spotify_id = items["id"]

            try:
                track_audio_data = sp.audio_analysis(spotify_id)
                tempo = track_audio_data.get("track").get("tempo")

            except:
                tempo = None

            if len(items["album"]["images"]) > 0:
                cover = items["album"]["images"][0]["url"]
            else:
                cover = None
            if len(sp.artist(artist_id=items["artists"][0]["uri"])["genres"]) > 0:
                genre = sp.artist(artist_id=items["artists"][0]["uri"])["genres"][0]
            else:
                genre = ""
        except Exception as e:
            parent_window.textbuffer.insert_at_cursor("WARN: Couldn't fetch the data.\n")

    if not client_id == "" and not client_secret == "" and not spotify_link_entry_text == "":
        command = f"""
        /usr/bin/yt-dlp -o "{folder_path}/{spotify_id}.%(ext)s" -x -f bestaudio --extract-audio --audio-quality 0 --audio-format mp3 {youtube_link_entry_text}
        """

    else:
        command = f"""
        /usr/bin/yt-dlp -o "{folder_path}/%(title)s.%(ext)s" --embed-metadata --embed-thumbnail -v --convert-thumbnail jpg --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\\"" --exec ffprobe -x -f bestaudio --extract-audio --audio-quality 0 --audio-format mp3 {youtube_link_entry_text}
        """

    def update_text_view(parent_window):
        if parent_window.text_view.is_visible() and parent_window.text_view.get_allocated_width() > 0:
            end_iter = parent_window.textbuffer.get_end_iter()
            parent_window.text_view.scroll_to_iter(end_iter, 0.0, False, 0.0, 1.0)
        return False

    def append_text(parent_window, text):
        end_iter = parent_window.textbuffer.get_end_iter()
        parent_window.textbuffer.insert(end_iter, text + "\n")
        if parent_window.text_view.is_visible() and parent_window.text_view.get_allocated_width() > 0:
            parent_window.text_view.scroll_to_iter(end_iter, 0.0, True, 0.0, 1.0)

    parent_window.update_text_view = update_text_view
    parent_window.append_text = append_text

    def on_timer(parent_window, source):
        text = source.readline()
        if text:
            GLib.idle_add(partial(append_text, parent_window, text.rstrip()))
            GLib.idle_add(partial(update_text_view, parent_window))
        return True

    def run_command(command, parent_window, on_completion):
        process = subprocess.Popen(
            command,
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            universal_newlines=True,
            bufsize=1,
        )
        
        for line in iter(process.stdout.readline, ''):
            GLib.idle_add(partial(append_text, parent_window, line.rstrip()))
            GLib.idle_add(partial(update_text_view, parent_window))
        
        process.stdout.close()
        process.wait()

        GLib.idle_add(on_completion)

    def on_thread_complete():
        if not client_id == "" and not client_secret == "" and not spotify_link_entry_text == "":
            mp3_file = f"{folder_path}/{spotify_id}.mp3"

            try:
                audio = EasyID3(mp3_file)
            except error:
                audio = mutagen.File(mp3_file, easy=True)
                audio.add_tags()

            audio['title'] = track_name
            audio['artist'] = track_artist
            audio['album'] = track_album
            audio['date'] = track_year
            audio['tracknumber'] = f"{str(track_num)}/ {str(album_total)}"
            if genre:
                audio['genre'] = genre
            audio.save()

            if cover:
                response = requests.get(cover)
                with open("cover.jpg", "wb") as cover_file:
                    cover_file.write(response.content)

                audio = ID3(mp3_file)
                with open("cover.jpg", 'rb') as albumart:
                    audio['APIC'] = APIC(
                        encoding=3,
                        mime='image/jpeg',
                        type=3,
                        desc=u'Cover',
                        data=albumart.read()
                    )
                audio.save()
                os.remove("cover.jpg")

            os.rename(mp3_file, f"{folder_path}/{track_name}.mp3")
        append_text(parent_window, f"\nDONE: File downloaded successfully!")
        append_text(parent_window, f"\n")


    thread = threading.Thread(target=run_command, args=(command, parent_window, on_thread_complete))
    thread.start()