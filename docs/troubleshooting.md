# Troubleshooting

## Linux: blank window, or the app exits with "Error 71 (Protocol error) dispatching to Wayland display"

This comes from WebKitGTK's DMA-BUF renderer, which misbehaves with some GPU drivers. It has been reported with NVIDIA's proprietary driver on both X11 and Wayland, and on Raspberry Pi 5.

On NVIDIA with Wayland, try this first. It keeps GPU rendering:

```
__NV_DISABLE_EXPLICIT_SYNC=1 smoothcsv-app
```

If that doesn't help, or you are on X11 or another GPU, disable the renderer:

```
WEBKIT_DISABLE_DMABUF_RENDERER=1 smoothcsv-app
```

To make either permanent, copy the desktop entry and edit its `Exec` line. The copy survives package updates:

```
cp /usr/share/applications/SmoothCSV.desktop ~/.local/share/applications/
# then, in the copy, insert "env WEBKIT_DISABLE_DMABUF_RENDERER=1 " right after "Exec="
```

Tracked in [#146](https://github.com/kohii/smoothcsv3/issues/146).
