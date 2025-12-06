#!/usr/bin/env python3

import sys
import os
from mutagen.id3 import ID3, TPE1, TPE2, TIT2, TALB, TRCK, TDRC, TXXX, error
from mutagen.mp3 import MP3

# --- Configuration ---
# All static tag values are defined here
ALBUM_ARTIST = "Above & Beyond"
TRACK_ARTIST = "Above & Beyond"
ALBUM_TITLE = "Group Therapy Radio"
YEAR = "2025"

# Replace with the actual MusicBrainz ID (as discussed previously)
MB_ALBUM_ARTIST_ID = "3e5463bf-dc93-40f7-9b0b-6a6752654f51"
MB_TAG_DESCRIPTION = 'MusicBrainz Album Artist Id'
# ---------------------

def tag_mp3_file(episode_number):
    """
    Constructs the filename, deletes existing tags, and sets new tags.
    """
    # 1. Construct the filename
    filename = f"Above & Beyond - Group Therapy Episode {episode_number}.mp3"

    # 2. Check for file existence
    if not os.path.exists(filename):
        print(f"❌ Error: File not found: {filename}")
        sys.exit(1)

    print(f"Processing: {filename}")

    try:
        # Load the MP3 file, forcing the use of the ID3 class for ID3v2 tags
        audio = MP3(filename, ID3=ID3)

        # 3. Delete existing ID3 tags (equivalent to id3v2 -D)
        # Note: Mutagen's clear() method deletes ALL tags in the frame.
        audio.tags.clear()
        print("   -> Existing tags removed.")

        # 4. Add new ID3 tags

        # TPE2 (Album Artist - equivalent to id3v2 --TPE2)
        audio.tags.add(TPE2(encoding=3, text=[ALBUM_ARTIST]))

        # TPE1 (Artist - equivalent to id3v2 -a)
        audio.tags.add(TPE1(encoding=3, text=[TRACK_ARTIST]))

        # TALB (Album Title - equivalent to id3v2 -A)
        audio.tags.add(TALB(encoding=3, text=[ALBUM_TITLE]))

        # TIT2 (Track Title - equivalent to id3v2 -t)
        audio.tags.add(TIT2(encoding=3, text=[f"{ALBUM_TITLE} {episode_number}"]))

        # TRCK (Track Number - equivalent to id3v2 -T for Episode Number)
        # TRCK is the correct frame for setting the Track/Episode number.
        audio.tags.add(TRCK(encoding=3, text=[str(episode_number)]))

        # TDRC (Year/Recording Time - equivalent to id3v2 -y)
        audio.tags.add(TDRC(encoding=3, text=[YEAR]))

        # Add MusicBrainz Album Artist ID (TXXX)
        audio.tags.add(TXXX(encoding=3, desc=MB_TAG_DESCRIPTION, text=[MB_ALBUM_ARTIST_ID]))

        # 5. Save the changes
        audio.save()

        print(f"✅ Success: Tags updated for episode {episode_number}.")

    except error as e:
        print(f"❌ Error during tagging: {e}")
    except Exception as e:
        print(f"❌ An unexpected error occurred: {e}")


if __name__ == "__main__":
    # Check if episode number was provided (equivalent to bash 'if [ $# -eq 0 ]')
    if len(sys.argv) < 2:
        print("Usage: python tag_episode.py <episode_number>")
        sys.exit(1)

    # Get the episode number from command line argument (equivalent to bash 'EPISODE=$1')
    EPISODE_NUMBER = sys.argv[1]

    tag_mp3_file(EPISODE_NUMBER)

    print(f"\nID3 tags updated successfully for Group Therapy episode {EPISODE_NUMBER}")
