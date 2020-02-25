#!/bin/sh
#
# Authors / Contributers: 
#	Christopher MJ Gray  | Product Management Engineer (SP) | F5 Networks | 609 310 1747      | cgray@f5.com
#
#
#
Version="0.0.10"
Updated="2/25/20"
TestedOn="BigIP 15.0 - 15.1"
#
# Source: https://clouddocs.f5.com/cli/tmsh-reference/latest/modules/net/
echo -e "
                                                                

\e[41m\e[97mMMMMMMMMMMMMMMMMWX0kdlc:;;;;;;;:clox0XWWMMMMMMMMMMMMMMMMMMMM\e[0m
\e[41m\e[97mMMMMMMMMMMMMWX0kdlc:;;;;;;;;;;;;;;;;:lox0XWMMMMMMMMMMMMMMMMM\e[0m
\e[41m\e[97mMMMMMMMMMWXOdc;;;;;;,;;;;;,,;;;;;;;;;;;;;cokXWMMMMMMMMMMMMMM\e[0m
\e[41m\e[97mMMMMMMMWKxc;;;,;;:clodddddl:;;;;;;;,;;;;;;;;cd0NMMMMMMMMMMMM\e[0m
\e[41m\e[97mMMMMMWKd:;,;:ldk0KXXNWWWWWN0dc;;;:oxxxxddoollccd0NMMMMMMMMMM\e[0m
\e[41m\e[97mMMMWXxc;;;lxKNWMWKxoodxOKNWWXdc;;dXWMMMWWWWNNXKKKNMMMMMMMMMM\e[0m
\e[41m\e[97mMMW0o;,;lONWMMMMNd;,;;;;:ldxo:;;lKWMMMMMMMMMMMMMMWXKNMMMMMMM\e[0m
\e[41m\e[97mMWOc;;;dXWMMMMMMXo,;;,;;;;;;;;;:kWWNKKKXXXXNNWWWWNxckNMMMMMM\e[0m
\e[41m\e[97mW0c;;;lKWMMMMMMWKl,;;;;;;;;;;;:dXWXd::::cccllloodoc;:kNMMMMM\e[0m
\e[41m\e[97mKo;,,;dNMMMMMMMWKl;;;:;:::;;;lxKWW0lc::;;;;;;;;;;;;;;c0WMMMM\e[0m
\e[41m\e[97md:cdxkKWMMMMMMMMNK00000K0Ol;:kNWMMNXXXK0Okxol:;;;;;,;;dXMMMM\e[0m
\e[41m\e[97mc;xXNWWMMMMMMMMMWNXXXXXKOdc;dXWMMMMMMMMMMMWWNKOdc;;;;;cOWMMM\e[0m
\e[41m\e[97m;;coodKWMMMMMMMW0occccc:;,;lKWMMMMMMMMMMMMMMMMMWXOl;;,;xNMMM\e[0m
\e[41m\e[97m;,;;;cOWMMMMMMMWO:;;;;;,;;:OWMMMMMMMMMMMMMMMMMMMMWXx:;;dNMMM\e[0m
\e[41m\e[97m;;;;;cOWMMMMMMMWO:;;;;;;;;dXWMWMMMMMMMMMMMMMMMMMMMMNk:;dNMMM\e[0m
\e[41m\e[97m:;;;;cOWMMMMMMMWO:,;;;;;,;coddxxkkOKXNWMMMMMMMMMMMMMXo:xNMMM\e[0m
\e[41m\e[97mc;;;;:OWMMMMMMMWOc;;;;;;;;;;;,,,;;;:cloxOKNMMMMMMMMMNxcOWMMM\e[0m
\e[41m\e[97mx;;;;:kWMMMMMMMW0c,;;;;;;;;;;;;;;;;;;;;;;:okXWMMMMMMNxdXMMMM\e[0m
\e[41m\e[97mKl;;;:kWMMMMMMMW0c,;;;;;;;;c:;;;;;;;;;;;;;;;oKWMMMMMKx0WMMMM\e[0m
\e[41m\e[97mW0c;;;dNMMMMMMMW0l;;;;;;;lkK0o:;;;;,;;;;;;,;;xNMMMMNOONMMMMM\e[0m
\e[41m\e[97mMWOc;;oXMMMMMMMWKl;;;;;;oKWMWX0d:;;;;;;;;;;;;xNMMMXO0NMMWNNW\e[0m
\e[41m\e[97mMMW0o:dXMMMMMMMMXo;;;;;;c0WMMMWNOl;;;;;;;;;:xXWWN0k0WMMWX000\e[0m
\e[41m\e[97mMMMWNXNWWMMMMMMMW0dolcc;;lKWMMMMWXkdlccclox0NNKkdxKWMMMWNKKK\e[0m
\e[41m\e[97mMMMMMMWKkxxkkOO0000000kl;;lxO0KKXXXXXKK000Okdlco0NMMMMMMMWWW\e[0m
\e[41m\e[97mMMMMMMMWKxc;;;;;;::::c:;;;;;;;:::clllllcc:;;cd0NMMMMMMMMMMMM\e[0m
\e[41m\e[97mMMMMMMMMMWXOdc;;,;;;,;;;;;;;;;;;;;;,;;;;;cokKWMMMMMMMMMMMMMM\e[0m
\e[41m\e[97mMMMMMMMMMMMMWX0kdl:;;;;;;;;;;;;;;;;;:lox0XWMMMMMMMMMMMMMMMMM\e[0m
\e[41m\e[97mMMMMMMMMMMMMMMMWWX0kdlc:;;;;;;;:cldxOXNWMMMMMMMMMMMMMMMMMMMM\e[0m
																			
						_   ___   ___ 
					   /_\ |   \ / __|
					  / _ \| |) | (__ 
					 /_/ \_\___/ \___|
									


Version: $Version 
Updated: $Updated
Tested On: $TestedOn

"