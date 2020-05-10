config.load_autoconfig()

config.bind('<Alt-q>', 'tab-close')
config.bind('<Alt-h>', 'tab-prev')
config.bind('<Alt-l>', 'tab-next')
config.bind('<Alt-j>', 'back')
config.bind('<Alt-k>', 'forward')
config.bind('H', 'scroll-px 200 0')
config.bind('L', 'scroll-px -200 0')
config.bind('J', 'scroll-px 0 200')
config.bind('K', 'scroll-px 0 -200')
config.bind('<F12>', 'inspector')
config.bind('I', 'hint -m number inputs normal')
config.bind('i', 'enter-mode insert')
config.bind('<Alt-f>', 'hint --rapid all tab-bg')
config.bind('t', 'set-cmd-text --space :buffer')
config.bind('b', 'set-cmd-text --space :bookmark-load -t')
config.bind('B', 'bookmark-add')
config.bind('<Alt-V>', 'enter-mode passthrough')
config.bind('o', 'set-cmd-text --space :open -t')
config.bind('O', 'set-cmd-text --space :open')
config.bind('gc', 'tab-clone')
config.bind('dd', 'download')
config.bind('do', 'download-open')
config.bind('dc', 'download-clear')
config.bind('dx', 'download-cancel')
config.bind('dD', 'download-delete')
config.unbind('d')
config.unbind('m')
config.unbind('M')
config.unbind('co')
config.unbind('<Ctrl-V>')

config.bind(',v', 'spawn mpv {url}')
config.bind(',V', 'hint links spawn mpv {hint-url}')

c.aliases['x'] = 'quit --save'
c.hints.selectors['all'].append('span[class~=link]')
c.hints.selectors['all'].append('span[class~=button]')
c.hints.selectors['all'].append('i[class~=close]')

c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "g":"https://www.google.com/search?q={}",
    "dev":"https://devdocs.io/#q={}",
    "syn":"https://thesaurus.com/browse/{}",
    "yt":"https://www.youtube.com/results?search_query={}",
    "tr":"https://translate.google.com/#view=home&op=translate&sl=hu&tl=en&text={}",
    "tr_en":"https://translate.google.com/#view=home&op=translate&sl=en&tl=hu&text={}",
}
c.completion.web_history.exclude = [
    "localhost", "duckduckgo.com", "devdocs.io",
    "thesaurus.com","dictionary.com","translate.google.com",
    "https://www.google.com/search"
]

c.editor.command = ["st", "-e", "nvim", "{}"]

import subprocess

def read_xresources(prefix):
    props = {}
    x = subprocess.run(['xrdb', '-query'], stdout=subprocess.PIPE)
    lines = x.stdout.decode().split('\n')
    for line in filter(lambda l : l.startswith(prefix), lines):
        prop, _, value = line.partition(':\t')
        props[prop] = value
    return props

xresources = read_xresources('')
c.colors.completion.category.bg = xresources['*background']
c.colors.completion.category.fg = xresources['*color3']
c.colors.completion.category.border.top = xresources['*background']
c.colors.completion.category.border.bottom = xresources['*color3']
c.colors.completion.even.bg = xresources['*background']
c.colors.completion.odd.bg = xresources['*color0']
c.colors.completion.fg = xresources['*foreground']
c.colors.completion.item.selected.bg = xresources['*color7']
c.colors.completion.item.selected.border.bottom = xresources['*color12']
c.colors.completion.item.selected.border.top = xresources['*color12']
c.colors.completion.item.selected.fg = xresources['*color0']
c.colors.completion.item.selected.match.fg = xresources['*color1']
c.colors.completion.scrollbar.bg = xresources['*background']
c.colors.completion.scrollbar.fg = xresources['*color8']

c.colors.contextmenu.menu.bg = xresources['*background']
c.colors.contextmenu.menu.fg = xresources['*foreground']
c.colors.contextmenu.selected.bg = xresources['*color7']
c.colors.contextmenu.selected.fg = xresources['*color0']

c.colors.hints.bg = xresources['*color11']
c.colors.hints.fg = xresources['URxvt.color234']
c.colors.hints.match.fg = xresources['*color1']

c.colors.keyhint.bg = xresources['*background']
c.colors.keyhint.fg = xresources['*foreground']
c.colors.keyhint.suffix.fg = xresources['*color1']

c.colors.messages.error.bg = xresources['*color1']
c.colors.messages.error.border = xresources['*color9']
c.colors.messages.error.fg = xresources['*foreground']

c.colors.messages.warning.bg = xresources['*color3']
c.colors.messages.warning.border = xresources['*color11']
c.colors.messages.warning.fg = xresources['*color0']

c.colors.messages.info.bg = xresources['*color4']
c.colors.messages.info.border = xresources['*color12']
c.colors.messages.info.fg = xresources['*color0']

c.colors.prompts.bg = xresources['*background']
c.colors.prompts.border = xresources['*background']
c.colors.prompts.fg = xresources['*foreground']
c.colors.prompts.selected.bg = xresources['*color7']

c.colors.statusbar.normal.bg = xresources['*background']
c.colors.statusbar.normal.fg = xresources['*foreground']
c.colors.statusbar.private.bg = '#fbf1c7'
c.colors.statusbar.private.fg = xresources['*color0']

c.colors.statusbar.command.bg = xresources['*background']
c.colors.statusbar.command.fg = xresources['*foreground']
c.colors.statusbar.command.private.bg = '#fbf1c7'
c.colors.statusbar.command.private.fg = xresources['*color0']

c.colors.statusbar.insert.bg = xresources['*color2']
c.colors.statusbar.insert.fg = xresources['*color0']

c.colors.statusbar.caret.bg = xresources['*color5']
c.colors.statusbar.caret.fg = xresources['*color0']
c.colors.statusbar.caret.selection.bg = xresources['*color13']
c.colors.statusbar.caret.selection.fg = xresources['*color0']

c.colors.statusbar.passthrough.bg = xresources['URxvt.color88']
c.colors.statusbar.passthrough.fg = xresources['*foreground']

c.colors.statusbar.progress.bg = xresources['*color3']

c.colors.statusbar.url.fg = xresources['*foreground']
c.colors.statusbar.url.hover.fg = xresources['*color12']
c.colors.statusbar.url.error.fg = xresources['*color1']
c.colors.statusbar.url.warn.fg = xresources['*color11']
c.colors.statusbar.url.success.http.fg = xresources['*color3']
c.colors.statusbar.url.success.https.fg = xresources['*color3']

c.colors.tabs.bar.bg = xresources['*background']
c.colors.tabs.even.bg = xresources['*background']
c.colors.tabs.even.fg = xresources['*foreground']
c.colors.tabs.odd.bg = xresources['*background']
c.colors.tabs.odd.fg = xresources['*foreground']
c.colors.tabs.selected.even.bg = xresources['*color4']
c.colors.tabs.selected.even.fg = xresources['URxvt.color234']
c.colors.tabs.selected.odd.bg = xresources['*color4']
c.colors.tabs.selected.odd.fg = xresources['URxvt.color234']

c.colors.tabs.pinned.even.bg = xresources['*background']
c.colors.tabs.pinned.even.fg = xresources['*foreground']
c.colors.tabs.pinned.odd.bg = xresources['*background']
c.colors.tabs.pinned.odd.fg = xresources['*foreground']
c.colors.tabs.pinned.selected.even.bg = xresources['*color6']
c.colors.tabs.pinned.selected.even.fg = xresources['URxvt.color234']
c.colors.tabs.pinned.selected.odd.bg = xresources['*color6']
c.colors.tabs.pinned.selected.odd.fg = xresources['URxvt.color234']

c.colors.tabs.indicator.error = xresources['*color1']
c.colors.tabs.indicator.start = xresources['*color3']
c.colors.tabs.indicator.stop = xresources['*color11']

c.colors.downloads.bar.bg = xresources['*background']
c.colors.downloads.error.bg = xresources['*color1']
c.colors.downloads.error.fg = xresources['*foreground']
c.colors.downloads.start.bg = xresources['*color3']
c.colors.downloads.start.fg = xresources['URxvt.color234']
c.colors.downloads.stop.bg = xresources['*color2']
c.colors.downloads.stop.fg = xresources['URxvt.color234']
