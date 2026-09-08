# MOOSE Sublime Text Support

Sublime Text syntax highlighting and editor support for MOOSE input files.

## Features

- Syntax highlighting for `.i` MOOSE input files
- MOOSE block and subblock highlighting
- Parameter and value highlighting
- MOOSE object/class highlighting
- Numeric, string, boolean, and expression highlighting
- `${...}` expression support
- `!include` highlighting
- `#` comment support
- Sublime LSP integration with the MOOSE language server
- Autocomplete
- Diagnostics
- Hover documentation

## Installation

Copy these files into your Sublime Text User package directory:

    ~/Library/Application Support/Sublime Text/Packages/User/

Files:

    MOOSE.sublime-syntax
    MOOSE-Comments.tmPreferences
    MOOSE.sublime-settings

## MOOSE Language Server

Install the Sublime Text `LSP` package.

Configure a MOOSE application executable that supports:

    --language-server

Example configuration:

    {
        "moose": {
            "enabled": true,
            "command": [
                "/path/to/your/moose-app-opt",
                "--language-server"
            ],
            "selector": "source.moose",
            "diagnostics_mode": "all_files"
        }
    }

See:

    examples/LanguageServers.sublime-settings.example

Using your own MOOSE application executable allows the language server to recognize custom application objects as well as standard MOOSE objects.

## MOOSE

MOOSE is the Multiphysics Object-Oriented Simulation Environment developed by Idaho National Laboratory.

https://mooseframework.inl.gov/
