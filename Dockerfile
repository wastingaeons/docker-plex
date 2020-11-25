FROM linuxserver/plex:latest
COPY . /
COPY /Chromecast.xml /usr/lib/plexmediaserver/Resources/Profiles/

