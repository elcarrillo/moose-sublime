# Setup Notes

Practical notes for getting the MOOSE Sublime setup working

## Where the Sublime user files live on Mac

the Sublime user package folder is

    ~/Library/Application Support/Sublime Text/Packages/User/

The Library folder is hidden by default on Mac

in Finder press

    Command + Shift + G

then paste

    ~/Library/Application Support/Sublime Text/Packages/User/

The main files from this repo that go there are

    MOOSE.sublime-syntax
    MOOSE-Comments.tmPreferences
    MOOSE.sublime-settings

## Syntax highlighting

MOOSE.sublime-syntax handles the MOOSE input file scopes

this includes

    block names
    parameter names
    MOOSE object and class names
    numbers
    strings
    comments
    expressions
    include statements

to see what scope Sublime is assigning to something

put the cursor on the text and use

    Tools -> Developer -> Show Scope Name

this is useful when changing highlighting

## custom colors

the syntax file decides what kind of token something is

the color scheme decides what color that scope gets

if two different MOOSE scopes are showing up as the same color
change the color scheme instead of changing the syntax scope

in Sublime open

    Tools -> Command Palette

search for

    Customize Color Scheme

open

    Preferences: Customize Color Scheme

Sublime opens two panels

The left panel is the default color scheme

DO NOT EDIT THE LEFT PANEL

The right panel is your user override

EDIT THE RIGHT PANEL

Inside the "rules" array, you can add MOOSE-specific color rules

for example

    {
        "name": "MOOSE integers",
        "scope": "source.moose constant.numeric.integer.moose",
        "foreground": "#C792EA"
    },
    {
        "name": "MOOSE block headers",
        "scope": "source.moose entity.name.section.moose",
        "foreground": "#82AAFF"
    }

JSON objects inside the rules array need commas between them

use

    },
    {

not

    }
    {

The example color scheme in this repo is

    examples/MOOSE-color-scheme.example.sublime-color-scheme

## comments

MOOSE-Comments.tmPreferences makes Command + / use

    #

for comments in MOOSE input files

## LSP package

install the Sublime package

    LSP

then configure a language server entry for MOOSE

an example is in

    examples/LanguageServers.sublime-settings.example

point the command at a MOOSE executable that supports

    --language-server

for a standard MOOSE build this could be something like

    /path/to/moose/modules/combined/combined-opt

for a custom MOOSE app use that app executable instead

    /path/to/your/custom-app-opt

using the custom app executable lets the language server recognize objects registered by that app


## hover documentation

manual hover can be mapped to

    lsp_hover

example Sublime key binding

    [
        {
            "keys": ["super+shift+h"],
            "command": "lsp_hover"
        }
    ]

on Mac

    super = Command

so this becomes

    Command + Shift + H

to edit key bindings use

    Preferences -> Key Bindings

the left panel is the default bindings

the right panel is your user key bindings

EDIT THE RIGHT PANEL

## automatic mouse hover

if manual hover works but mouse hover does not

open

    View -> Show Console

and run

    sublime.active_window().settings().set("lsp_show_hover_popups", True)

Then move the mouse over a valid MOOSE parameter or value

## Checking the LSP log

to see communication between Sublime and the MOOSE language server use

    Tools -> LSP -> Toggle Log Panel

useful messages include

    initialize
    textDocument/hover
    diagnostics
    completion

if autocomplete and diagnostics work but hover does not
test manual lsp_hover before changing other settings

## Custom MOOSE apps and main.C

older custom MOOSE apps may still use the deprecated AppFactory::createAppShared setup in main.C

newer MOOSE applications use MooseMain.h and Moose::main

example

    #include "MyApp.h"
    #include "MooseMain.h"

    int
    main(int argc, char * argv[])
    {
      return Moose::main<MyApp>(argc, argv);
    }

Changing main.C requires rebuilding the custom app executable

## Mac duplicate LC_RPATH issue

A rebuilt MOOSE app on Mac can sometimes fail with

    duplicate LC_RPATH

check the executable with

    otool -l ./your-app-opt | awk '/LC_RPATH/{getline; getline; print $2}' | sort | uniq -c

If the Conda lib path appears more than once
remove duplicates until only one remains

    while [ "$(otool -l ./your-app-opt | awk '/LC_RPATH/{getline; getline; print $2}' | grep -Fx "$CONDA_PREFIX/lib" | wc -l)" -gt 1 ]; do
      install_name_tool -delete_rpath "$CONDA_PREFIX/lib" ./your-app-opt
    done

then re-sign

    codesign --force --sign - ./your-app-opt

and check it

    ./your-app-opt --version

## useful files

    MOOSE.sublime-syntax
        MOOSE syntax scopes and highlighting

    MOOSE-Comments.tmPreferences
        comment behavior

    MOOSE.sublime-settings
        MOOSE specific Sublime settings

    examples/LanguageServers.sublime-settings.example
        example LSP configuration

    examples/MOOSE-color-scheme.example.sublime-color-scheme
        optional custom colors

    tests/syntax_test_moose.i
        syntax test file

## quick debugging

If something looks wrong visually

    check the scope first

if autocomplete or diagnostics are broken

    check the LSP connection

if manual hover works but mouse hover does not

    check the Sublime hover setting first

when Sublime opens a default panel on the left and a user panel on the right

    EDIT THE RIGHT PANEL
