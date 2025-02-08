#!/bin/bash
sudo rm /var/cache/fontconfig/*
rm ~/.cache/fontconfig/*
fc-cache -r

