juggernaut_command:
    type: command
    name: juggernaut
    description: Juggernaut command.
    usage: /juggernaut
    script:
    - define args <context.args>
    - foreach <[args]>:
        - if <[value].regex_matches[^-.*]>:
            - define args:<-:<[value]>
            - define mods:->:<[value]>
    - choose <[args].get[1]>:
        - case map:
            - if <[mods].contains[-b]>:
                - define skipBackup true
            - narrate <[skipBackup]>
            - choose <[args].get[2]>:
                - case create:
                    - define perm cubeville.juggernaut.map.create
                    - inject jug_perms
                    - if <player.has_flag[jug_setup]>:
                        - narrate "<&c>You already have another chat selection active. If this is unintentional type <proc[jug_setup_proc].context[cancel|normal]><&c>!"
                        - stop
                    - if !<[args].get[3].matches_character_set[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_]>:
                        - narrate "<&c>Invalid characters specified!"
                        - stop
                    - if <server.flag[juggernaut_maps.<[args].get[3]>].exists>:
                        - narrate "<&c>There is already a map with that name!"
                        - stop
                    - if <[args].get[3].exists>:
                        - narrate "<&7>Please type in <proc[jug_setup_proc].context[<&lt>display<&sp>name<&gt>|input]> <&7>to set the display name of the map, or type <proc[jug_setup_proc].context[cancel|normal]> <&7>to cancel setup. You can use color codes such as &6 for vanilla colors or &#ff55ff for hex colors." targets:<player>
                        - flag <player> jug_setup:1
                        - flag <player> current_map_setup_map:<map[]>
                        - flag <player> current_map_setup_name:<[args].get[3]>
                        - if <[skipBackup].exists>:
                            - flag <player> skip_backup:true
                        - if <[mods].contains[-c]>::
                            - flag <player> auto_close:true
                    - else:
                        - define prop_com "/juggernaut map create <&lt>name<&gt>"
                        - narrate <proc[jug_mis_arg].context[name|<[prop_com]>]>
                - case remove:
                    - define perm cubeville.juggernaut.map.remove
                    - inject jug_perms
                    - if <player.has_flag[jug_setup]>:
                        - narrate "<&c>You already have another chat selection active. If this is unintentional type <proc[jug_setup_proc].context[cancel|normal]><&c>!"
                        - stop
                    - if <[args].get[3].exists>:
                        - if <server.flag[juggernaut_maps].keys.contains[<[args].get[3]>]>:
                            - flag <player> remove_map:<[args].get[3]>
                            - flag <player> jug_setup:remove
                            - if <[skipBackup].exists>:
                                - flag <player> skip_backup:true
                            - narrate "<&7>Please type in <proc[jug_setup_proc].context[confirm|normal]> <&7>to remove map, or <proc[jug_setup_proc].context[cancel|normal]> <&7>to cancel."
                        - else:
                            - narrate "<&c>Invalid map specified."
                    - else:
                        - define prop_com "/juggernaut map remove <&lt>name<&gt>"
                        - narrate <proc[jug_mis_arg].context[name|<[prop_com]>]>
                - case end:
                    - define perm cubeville.juggernaut.map.end
                    - inject jug_perms
                    - if <[args].get[3].exists>:
                        - if <server.flag[juggernaut_maps].keys.contains[<[args].get[3]>]>:
                            - flag server juggernaut_maps.<[args].get[3]>.game_data.countdown:!
                            - flag server juggernaut_maps.<[args].get[3]>.game_data.saved_countdown:!
                            - run jug_stop_game def:<[args].get[3]>
                            - narrate "<&a><[args].get[3]> <&7>game ended."
                        - else:
                            - narrate "<&c>Invalid map specified."
                    - else:
                        - define prop_com "/juggernaut map end <&lt>name<&gt>"
                        - narrate <proc[jug_mis_arg].context[name|<[prop_com]>]>
                - case close:
                    - define perm cubeville.juggernaut.map.close
                    - inject jug_perms
                    - if <[args].get[3].exists>:
                        - if <server.flag[juggernaut_maps.<[args].get[3]>.game_data.players].keys.size> != 0:
                            - narrate "<&c>There are players currently on this map! In order to close this map, there must be no players on this map."
                            - stop
                        - if <server.flag[juggernaut_maps].keys.contains[<[args].get[3]>]>:
                            - flag server juggernaut_maps.<[args].get[3]>.game_data.phase:-1
                            - narrate "<&a><[args].get[3]> <&7>closed."
                        - else:
                            - narrate "<&c>Invalid map specified."
                    - else:
                        - define prop_com "/juggernaut map close <&lt>name<&gt>"
                        - narrate <proc[jug_mis_arg].context[name|<[prop_com]>]>
                - case open:
                    - define perm cubeville.juggernaut.map.open
                    - inject jug_perms
                    - if <[args].get[3].exists>:
                        - if <server.flag[juggernaut_maps].keys.contains[<[args].get[3]>]>:
                            - flag server juggernaut_maps.<[args].get[3]>.game_data.phase:0
                            - narrate "<&a><[args].get[3]> <&7>opened."
                        - else:
                            - narrate "<&c>Invalid map specified."
                    - else:
                        - define prop_com "/juggernaut map open <&lt>name<&gt>"
                        - narrate <proc[jug_mis_arg].context[name|<[prop_com]>]>
                - case help:
                    - define perm cubeville.juggernaut.map.help
                    - inject jug_perms
                    - narrate <proc[jug_help_proc].context[map]>
                - default:
                    - define perm cubeville.juggernaut.map.help
                    - inject jug_perms
                    - define prop_com "/juggernaut map help"
                    - narrate <proc[jug_help_arg].context[<[prop_com]>]>
        - case open:
            - define perm cubeville.juggernaut.open
            - inject jug_perms
            - flag <player> gui_page:1
            - inventory open d:jug_map_selection_gui
        - case reload:
            - define perm cubeville.juggernaut.reload
            - inject jug_perms
            - yaml load:juggernaut.yml id:juggernaut
            - narrate "<&a>Juggernaut config reloaded!"
        - case leave:
            - define perm cubeville.juggernaut.leave
            - inject jug_perms
            - if <player.has_flag[juggernaut_data.in_game]>:
                - run jug_remove_player def:<player.flag[juggernaut_data].get[map]>
            - else:
                - narrate "<&c>You aren't in a game!"
        - case setspawn:
            - define perm cubeville.juggernaut.setspawn
            - inject jug_perms
            - if <player.has_flag[jug_setup]>:
                    - narrate "<&c>You already have another chat selection active. If this is unintentional type <proc[jug_setup_proc].context[cancel|normal]><&c>!"
                    - stop
            - flag <player> jug_setup:spawn
            - narrate "<&7>Please stand where the Juggernaut lobby's spawn should be and type in one of the following: <&nl><proc[jug_setup_proc].context[save|normal]><&7>: Save an auto-corrected location <&nl><proc[jug_setup_proc].context[exact|normal]><&7>: Save your exact location <&nl><proc[jug_setup_proc].context[cancel|normal]><&7>: Cancel setting the spawn." targets:<player>
        - case help:
            - define perm cubeville.juggernaut.help
            - inject jug_perms
            - narrate <proc[jug_help_proc].context[general]>
        - case setup:
            - define perm cubeville.juggernaut.setup
            - inject jug_perms
            - run jug_setup_task def:<context.args.get[2].to[last].space_separated>
        - case debug:
            - choose <[args].get[2]>:
                - case map:
                    - define perm cubeville.juggernaut.debug.map
                    - inject jug_perms
                    - if !<server.flag[juggernaut_maps.<[args].get[3]>].exists> && <[args].get[3].exists>:
                        - narrate "<&c>That map doesn't exist!"
                        - stop
                    - else if <[args].get[3].exists>:
                        - narrate <server.flag[juggernaut_maps.<[args].get[3]>]>
                    - else:
                        - narrate <server.flag[juggernaut_maps]>
                - case player:
                    - define perm cubeville.juggernaut.debug.player
                    - inject jug_perms
                    - if !<[args].get[3].exists>:
                        - define prop_com "/juggernaut debug player <&lt>name<&gt>"
                        - narrate <proc[jug_mis_arg].context[name|<[prop_com]>]>
                        - stop
                    - if !<server.match_offline_player[<[args].get[3]>].exists> || <server.match_offline_player[<[args].get[3]>].name> != <[args].get[3]>:
                        - narrate "<&c>That player doesn't exist!"
                        - stop
                    - narrate <server.match_offline_player[<[args].get[3]>].flag[juggernaut_data]>
                - case help:
                    - define perm cubeville.juggernaut.debug.help
                    - inject jug_perms
                    - narrate <proc[jug_help_proc].context[debug]>
                - default:
                    - define perm cubeville.juggernaut.debug.help
                    - inject jug_perms
                    - define prop_com "/juggernaut debug help"
                    - narrate <proc[jug_help_arg].context[<[prop_com]>]>
        - case backup:
            - choose <[args].get[2]>:
                - case load:
                    - define perm cubeville.juggernaut.backup.load
                    - inject jug_perms
                    - if <player.has_flag[jug_setup]>:
                        - narrate "<&c>You already have another chat selection active. If this is unintentional type <proc[jug_setup_proc].context[cancel|normal]><&c>!"
                        - stop
                    - if <[args].get[3].exists>:
                        - if <server.flag[juggernaut_backup_maps].keys.contains[<[args].get[3]>]>:
                            - flag <player> load_map:<[args].get[3]>
                            - flag <player> jug_setup:backup_load
                            - if <server.flag[juggernaut_maps].keys.contains[<[args].get[3]>]>:
                                - narrate "<&7>Please type in <proc[jug_setup_proc].context[confirm|normal]> <&7>to load map from backup, or <proc[jug_setup_proc].context[cancel|normal]> <&7>to cancel. <&c>(!!! This map already exists)"
                            - else:
                                - narrate "<&7>Please type in <proc[jug_setup_proc].context[confirm|normal]> <&7>to load map from backup, or <proc[jug_setup_proc].context[cancel|normal]> <&7>to cancel."
                        - else:
                            - narrate "<&c>Invalid map specified."
                    - else:
                        - define prop_com "/juggernaut backup load <&lt>name<&gt>"
                        - narrate <proc[jug_mis_arg].context[name|<[prop_com]>]>
                - case remove:
                    - define perm cubeville.juggernaut.backup.remove
                    - inject jug_perms
                    - if <player.has_flag[jug_setup]>:
                        - narrate "<&c>You already have another chat selection active. If this is unintentional type <proc[jug_setup_proc].context[cancel|normal]><&c>!"
                        - stop
                    - if <[args].get[3].exists>:
                        - if <server.flag[juggernaut_backup_maps].keys.contains[<[args].get[3]>]>:
                            - flag <player> remove_map:<[args].get[3]>
                            - flag <player> jug_setup:backup_remove
                            - narrate "<&7>Please type in <proc[jug_setup_proc].context[confirm|normal]> <&7>to remove backup map, or <proc[jug_setup_proc].context[cancel|normal]> <&7>to cancel."
                        - else:
                            - narrate "<&c>Invalid map specified."
                    - else:
                        - define prop_com "/juggernaut backup remove <&lt>name<&gt>"
                        - narrate <proc[jug_mis_arg].context[name|<[prop_com]>]>
                - case save:
                    - define perm cubeville.juggernaut.backup.save
                    - inject jug_perms
                    - if <player.has_flag[jug_setup]>:
                        - narrate "<&c>You already have another chat selection active. If this is unintentional type <proc[jug_setup_proc].context[cancel|normal]><&c>!"
                        - stop
                    - if <[args].get[3].exists>:
                        - if <server.flag[juggernaut_maps].keys.contains[<[args].get[3]>]>:
                            - flag <player> save_map:<[args].get[3]>
                            - flag <player> jug_setup:backup_save
                            - if <server.flag[juggernaut_backup_maps].keys.contains[<[args].get[3]>]>:
                                - narrate "<&7>Please type in <proc[jug_setup_proc].context[confirm|normal]> <&7>to save map to a backup, or <proc[jug_setup_proc].context[cancel|normal]> <&7>to cancel. <&c>(!!! This backup already exists)"
                            - else:
                                - narrate "<&7>Please type in <proc[jug_setup_proc].context[confirm|normal]> <&7>to save map to a backup, or <proc[jug_setup_proc].context[cancel|normal]> <&7>to cancel."
                        - else:
                            - narrate "<&c>Invalid map specified."
                    - else:
                        - define prop_com "/juggernaut backup save <&lt>name<&gt>"
                        - narrate <proc[jug_mis_arg].context[name|<[prop_com]>]>
                - case list:
                    - define perm cubeville.juggernaut.backup.list
                    - inject jug_perms
                    - narrate <server.flag[juggernaut_backup_maps].keys.separated_by[,<&sp>]>
                - case help:
                    - define perm cubeville.juggernaut.backup.help
                    - inject jug_perms
                    - narrate <proc[jug_help_proc].context[backup]>
                - default:
                    - define perm cubeville.juggernaut.backup.help
                    - inject jug_perms
                    - define prop_com "/juggernaut backup help"
                    - narrate <proc[jug_help_arg].context[<[prop_com]>]>
        - default:
            - define perm cubeville.juggernaut.help
            - inject jug_perms
            - define prop_com "/juggernaut help"
            - narrate <proc[jug_help_arg].context[<[prop_com]>]>
jug_perms:
    type: task
    definitions: perm
    script:
    - if !<player.has_permission[<[perm]>]>:
        - narrate "<&c>No permission!"
        - stop
jug_help_proc:
    type: procedure
    definitions: type
    script:
    - define list <list[]>
    - if <[type]> == general:
        - define list:->:<&e><&l>Help<&sp>for<&sp>Juggernaut<&co>
        - if <player.has_permission[cubeville.juggernaut.map.help]>:
            - define msg "<&a>/juggernaut map <&c><&l><element[^].on_click[/juggernaut<&sp>map<&sp>help].on_hover[<&7>Click<&sp>here<&sp>for<&sp>map<&sp>help.]> <&7>- Commands involving the management of maps"
            - define list:->:<[msg]>
        - if <player.has_permission[cubeville.juggernaut.debug.help]>:
            - define msg "<&a>/juggernaut debug <&c><&l><element[^].on_click[/juggernaut<&sp>debug<&sp>help].on_hover[<&7>Click<&sp>here<&sp>for<&sp>debug<&sp>help.]> <&7>- Commands to assist with debugging"
            - define list:->:<[msg]>
        - if <player.has_permission[cubeville.juggernaut.backup.help]>:
            - define msg "<&a>/juggernaut backup <&c><&l><element[^].on_click[/juggernaut<&sp>backup<&sp>help].on_hover[<&7>Click<&sp>here<&sp>for<&sp>backup<&sp>help.]> <&7>- Commands to interact with map backups"
            - define list:->:<[msg]>
        - if <player.has_permission[cubeville.juggernaut.open]>:
            - define msg "<&a>/juggernaut open <&7>- Opens the map selection menu"
            - define list:->:<[msg]>
        - if <player.has_permission[cubeville.juggernaut.reload]>:
            - define msg "<&a>/juggernaut reload <&7>- Reloads the Juggernaut config files"
            - define list:->:<[msg]>
        - if <player.has_permission[cubeville.juggernaut.leave]>:
            - define msg "<&a>/juggernaut leave <&7>- Leaves the game you are currently in"
            - define list:->:<[msg]>
        - if <player.has_permission[cubeville.juggernaut.setspawn]>:
            - define msg "<&a>/juggernaut setspawn <&7>- Sets the location players spawn after leaving a game"
            - define list:->:<[msg]>
        - if <player.has_permission[cubeville.juggernaut.setup]>:
            - define msg "<&a>/juggernaut setup <&7>- Used whenever chat-style inputs are required"
            - define list:->:<[msg]>
    - else if <[type]> == map:
        - define list:->:<&e><&l>Help<&sp>for<&sp>Juggernaut<&sp>maps<&co>
        - if <player.has_permission[cubeville.juggernaut.map.create]>:
            - define msg "<&a>/juggernaut map create <&lt>name<&gt> <element[<&e>[-b]].on_hover[<&7>Prevent<&sp>saving<&sp>changes<&sp>to<&sp>backup]> <&7>- Starts setup process for a new map"
            - define list:->:<[msg]>
        - if <player.has_permission[cubeville.juggernaut.map.remove]>:
            - define msg "<&a>/juggernaut map remove <&lt>name<&gt> <element[<&e>[-b]].on_hover[<&7>Prevent<&sp>saving<&sp>changes<&sp>to<&sp>backup]> <&7>- Removes a map"
            - define list:->:<[msg]>
        - if <player.has_permission[cubeville.juggernaut.map.end]>:
            - define msg "<&a>/juggernaut map end <&lt>name<&gt> <&7>- Ends the current game running on this map"
            - define list:->:<[msg]>
        - if <player.has_permission[cubeville.juggernaut.map.close]>:
            - define msg "<&a>/juggernaut map close <&lt>name<&gt> <&7>- Closes this map, meaning nobody can enter"
            - define list:->:<[msg]>
        - if <player.has_permission[cubeville.juggernaut.map.open]>:
            - define msg "<&a>/juggernaut map open <&lt>name<&gt> <&7>- Opens this map, allowing players to enter"
            - define list:->:<[msg]>
    - else if <[type]> == debug:
        - define list:->:<&e><&l>Help<&sp>for<&sp>debug<&sp>commands<&co>
        - if <player.has_permission[cubeville.juggernaut.debug.map]>:
            - define msg "<&a>/juggernaut debug map [name] <&7>- Shows juggernaut data for a map. If no map is specified, shows juggernaut data for all maps."
            - define list:->:<[msg]>
        - if <player.has_permission[cubeville.juggernaut.debug.player]>:
            - define msg "<&a>/juggernaut debug player <&lt>name<&gt> <&7>- Shows juggernaut data for a player"
            - define list:->:<[msg]>
    - else if <[type]> == backup:
        - define list:->:<&e><&l>Help<&sp>for<&sp>debug<&sp>commands<&co>
        - if <player.has_permission[cubeville.juggernaut.backup.save]>:
            - define msg "<&a>/juggernaut backup save <&lt>name<&gt> <&7>- Saves the current form of the map to a backup. This replaces any current backup of this map."
            - define list:->:<[msg]>
        - if <player.has_permission[cubeville.juggernaut.backup.load]>:
            - define msg "<&a>/juggernaut backup load <&lt>name<&gt> <&7>- Loads the backup of a map to be the current map. This replaces any current version of this map."
            - define list:->:<[msg]>
        - if <player.has_permission[cubeville.juggernaut.backup.remove]>:
            - define msg "<&a>/juggernaut backup remove <&lt>name<&gt> <&7>- Removes the backup of a map."
            - define list:->:<[msg]>
        - if <player.has_permission[cubeville.juggernaut.backup.list]>:
            - define msg "<&a>/juggernaut backup list <&7>- Lists the names of all current backup maps."
            - define list:->:<[msg]>
    - determine <[list].separated_by[<&nl>]>
jug_mis_arg:
    type: procedure
    definitions: arg|command
    script:
    - determine "<&c>Missing argument for <&e><&lt><&6><[arg]><&e><&gt><&c>. <&nl><&c>Usage: <&6><[command].replace_text[<&gt>].with[<&e><&gt><&6>].replace_text[<&lt>].with[<&e><&lt><&6>]>"
jug_help_arg:
    type: procedure
    definitions: command
    script:
    - determine "<&c>Missing or invalid arguments. <&nl><&c>Help: <&6><[command].replace_text[<&gt>].with[<&e><&gt><&6>].replace_text[<&lt>].with[<&e><&lt><&6>]>"
jug_setup_task:
    type: task
    definitions: message
    script:
    - if <player.has_flag[jug_setup]> && <[message]> == cancel:
        - flag <player> jug_setup:!
        - flag <player> current_map_setup_map:!
        - flag <player> current_map_setup_name:!
        - flag <player> skip_backup:!
        - flag <player> remove_map:!
        - flag <player> save_map:!
        - flag <player> load_map:!
        - narrate <&a>Cancelled!
        - stop
    - if <player.flag[jug_setup]> == 1:
        - flag <player> current_map_setup_map:<player.flag[current_map_setup_map].with[display_name].as[<[message]>]>
        - flag <player> jug_setup:2
        - narrate "<&7>Please select the item to represent the map in your inventory, or type <proc[jug_setup_proc].context[cancel|normal]> <&7>to cancel setup." targets:<player>
    - else if <player.flag[jug_setup]> == 3:
        - if <[message]> == save:
            - define location <player.location.round_down.add[0.5,0.5,0.5].with_yaw[<player.location.yaw.round_to_precision[45]>].with_pitch[0]>
        - else if <[message]> == exact:
            - define location <player.location>
        - else:
            - narrate "<&c>Invalid choice!"
            - stop
        - flag <player> current_map_setup_map:<player.flag[current_map_setup_map].with[waiting_spawn].as[<[location]>]>
        - flag <player> jug_setup:4
        - narrate "<&7>Please stand where the main spawn should be and type in one of the following: <&nl><proc[jug_setup_proc].context[save|normal]><&7>: Save an auto-corrected location <&nl><proc[jug_setup_proc].context[exact|normal]><&7>: Save your exact location <&nl><proc[jug_setup_proc].context[cancel|normal]><&7>: Cancel the map creation." targets:<player>
    - else if <player.flag[jug_setup]> == 4:
        - if <[message]> == save:
            - define location <player.location.round_down.add[0.5,0.5,0.5].with_yaw[<player.location.yaw.round_to_precision[45]>].with_pitch[0]>
        - else if <[message]> == exact:
            - define location <player.location>
        - else:
            - narrate "<&c>Invalid choice!"
            - stop
        - flag <player> current_map_setup_map:<player.flag[current_map_setup_map].with[spawn].as[<[location]>]>
        - flag <player> jug_setup:5
        - narrate "<&7>Please stand where the juggernaut spawn should be and type in one of the following: <&nl><proc[jug_setup_proc].context[save|normal]><&7>: Save an auto-corrected location <&nl><proc[jug_setup_proc].context[exact|normal]><&7>: Save your exact location <&nl><proc[jug_setup_proc].context[cancel|normal]><&7>: Cancel the map creation." targets:<player>
    - else if <player.flag[jug_setup]> == 5:
        - if <[message]> == save:
            - define location <player.location.round_down.add[0.5,0.5,0.5].with_yaw[<player.location.yaw.round_to_precision[45]>].with_pitch[0]>
        - else if <[message]> == exact:
            - define location <player.location>
        - else:
            - narrate "<&c>Invalid choice!"
            - stop
        - flag <player> current_map_setup_map:<player.flag[current_map_setup_map].with[jug_spawn].as[<[location]>]>
        - flag <player> jug_setup:6
        - narrate "<&7>Please create a worldedit region around the map and type in one of the following: <&nl><proc[jug_setup_proc].context[save|normal]><&7>: Save the WorldEdit region <&nl><proc[jug_setup_proc].context[cancel|normal]><&7>: Cancel the map creation." targets:<player>
# The below must be the final step as it does a permanent thing.
    - else if <player.flag[jug_setup]> == 6:
        - if <[message]> == save:
            - if <player.we_selection.exists>:
                - define region <player.we_selection>
                - flag <player> current_map_setup_map:<player.flag[current_map_setup_map].with[region].as[<[region]>]>
                - note <[region]> as:jug_<player.flag[current_map_setup_name]>
            - else:
                - narrate "<&c>Make a WorldEdit region selection first."
                - stop
        - if <player.has_flag[auto_close]>:
            - define phase -1
            - flag <player> auto_close:!
        - flag <player> current_map_setup_map:<player.flag[current_map_setup_map].with[game_data].as[<map[].with[players].as[].with[spectators].as[<list[]>].with[juggernaut].as[].with[phase].as[<[phase].if_null[0]>].with[dead].as[].with[countdown].as[0].with[saved_countdown].as[0].with[ready_players].as[<list[]>]>]>
        - if !<server.has_flag[juggernaut_maps]>:
            - flag server juggernaut_maps:<map[]>
        - flag server juggernaut_maps.<player.flag[current_map_setup_name]>:<player.flag[current_map_setup_map]>
        - if !<player.has_flag[skip_backup]>:
            - flag server juggernaut_backup_maps.<player.flag[current_map_setup_name]>:<player.flag[current_map_setup_map]>
        - else:
            - flag <player> skip_backup:!
        - flag <player> jug_setup:!
        - narrate <server.flag[juggernaut_maps]>
    - else if <player.flag[jug_setup]> == spawn:
        - if <[message]> == save:
            - define location <player.location.round_down.add[0.5,0.5,0.5].with_yaw[<player.location.yaw.round_to_precision[45]>].with_pitch[0]>
        - else if <[message]> == exact:
            - define location <player.location>
        - else:
            - narrate "<&c>Invalid choice!"
            - stop
        - flag server juggernaut_spawn:<[location]>
        - narrate "<&a>Juggernaut spawn saved!"
        - flag <player> jug_setup:!
    - else if <player.flag[jug_setup]> == remove:
        - if <[message]> == confirm:
            - run jug_stop_game def:<player.flag[remove_map]>
            - note remove as:jug_<player.flag[remove_map]>
            - flag server juggernaut_maps.<player.flag[remove_map]>.game_data.countdown:!
            - flag server juggernaut_maps.<player.flag[remove_map]>.game_data.saved_countdown:!
            - flag server juggernaut_maps.<player.flag[remove_map]>:!
            - if !<player.has_flag[skip_backup]>:
                - flag server juggernaut_backup_maps.<player.flag[remove_map]>:!
            - else:
                - flag <player> skip_backup:!
            - narrate "<&a><player.flag[remove_map]> <&7>map successfully removed."
        - else:
            - narrate "<&c>Invalid choice!"
            - stop
        - flag <player> jug_setup:!
        - flag <player> remove_map:!
    - else if <player.flag[jug_setup]> == backup_remove:
        - if <[message]> == confirm:
            - flag server juggernaut_backup_maps.<player.flag[remove_map]>:!
            - narrate "<&a><player.flag[remove_map]> <&7>backup map successfully removed."
        - else:
            - narrate "<&c>Invalid choice!"
            - stop
        - flag <player> jug_setup:!
        - flag <player> remove_map:!
    - else if <player.flag[jug_setup]> == backup_load:
        - if <server.flag[juggernaut_maps.<player.flag[load_map]>.game_data.players].keys.size> != 0:
            - narrate "<&c>There must be no players in the active map in order to load/save maps to/from a backup!"
            - stop
        - if <[message]> == confirm:
            - note <server.flag[juggernaut_backup_maps.<player.flag[load_map]>.region]> as:jug_<player.flag[load_map]>
            - flag server juggernaut_maps.<player.flag[load_map]>:<server.flag[juggernaut_backup_maps.<player.flag[load_map]>]>
            - narrate <server.flag[juggernaut_backup_maps.<player.flag[load_map]>]>
            - narrate "<&a><player.flag[load_map]> <&7>map successfully loaded."
        - else:
            - narrate "<&c>Invalid choice!"
            - stop
        - flag <player> jug_setup:!
        - flag <player> load_map:!
    - else if <player.flag[jug_setup]> == backup_save:
        - if <server.flag[juggernaut_maps.<player.flag[save_map]>.game_data.players].keys.size> != 0:
            - narrate "<&c>There must be no players in the active map in order to load/save maps to/from a backup!"
            - stop
        - if <[message]> == confirm:
            - flag server juggernaut_backup_maps.<player.flag[save_map]>:<server.flag[juggernaut_maps.<player.flag[save_map]>]>
            - narrate "<&a><player.flag[save_map]> <&7>map successfully saved to a backup."
        - else:
            - narrate "<&c>Invalid choice!"
            - stop
        - flag <player> jug_setup:!
        - flag <player> save_map:!
jug_setup_event:
    type: world
    events:
        on player flagged:jug_setup clicks in player*:
        - if <player.flag[jug_setup]> == 2:
            - determine passively cancelled
            - if <context.item> != <item[air]>:
                - flag <player> current_map_setup_map:<player.flag[current_map_setup_map].with[display_item].as[<context.item>]>
                - flag <player> jug_setup:3
                - narrate "<&7>Please stand where the waiting lobby spawn should be and type in one of the following: <&nl><proc[jug_setup_proc].context[save|normal]><&7>: Save an auto-corrected location <&nl><proc[jug_setup_proc].context[exact|normal]><&7>: Save your exact location <&nl><proc[jug_setup_proc].context[cancel|normal]><&7>: Cancel the map creation." targets:<player>
            - else:
                - narrate "<&c>Display item must not be air."
jug_setup_proc:
    type: procedure
    definitions: arg|type
    script:
    - if <[type]> == normal:
        - determine <&a><element[/juggernaut<&sp>setup<&sp><[arg]>].on_click[/juggernaut<&sp>setup<&sp><[arg]>].type[SUGGEST_COMMAND].on_hover[<&7>Click<&sp>to<&sp>put<&sp>command<&sp>in<&sp>your<&sp>chat<&sp>bar.]>
    - else if <[type]> == input:
        - determine <&a><element[/juggernaut<&sp>setup<&sp><[arg]>].on_click[/juggernaut<&sp>setup].type[SUGGEST_COMMAND].on_hover[<&7>Click<&sp>to<&sp>put<&sp>command<&sp>in<&sp>your<&sp>chat<&sp>bar.]>
jug_deny_map_leave:
    type: world
    events:
        on player exits jug_*:
        - if <player.flag[juggernaut_data].get[map]> == <context.area.note_name.after[jug_]>:
            - if <player.flag[juggernaut_data].get[leave_spam].if_null[0]> < <yaml[juggernaut].read[leave_spam_limit]>:
                - narrate "<&c>Leaving is not allowed!"
                - wait 1t
                - teleport <player> <context.from>
                - flag <player> juggernaut_data.leave_spam:+:1
                - wait <yaml[juggernaut].read[leave_spam_rate]>s
                - if <player.flag[juggernaut_data.leave_spam].exists>:
                    - flag <player> juggernaut_data.leave_spam:-:1
            - else:
                - narrate "<&c>Teleported to map spawn!"
                - teleport <player> to:<server.flag[juggernaut_maps].deep_get[<player.flag[juggernaut_data.map]>.spawn]>
jug_map_selection_gui:
  type: inventory
  inventory: CHEST
  title: Juggernaut Maps
  size: 54
  gui: true
  debug: false
  definitions:
    g: black_stained_glass_pane[display_name=<&sp>]
    t: jug_tutorial_item
  procedural items:
    - define size 28
    - define pageMin <[size].mul[<player.flag[gui_page].sub[1]>].add[1]>
    - define pageMax <[size].mul[<player.flag[gui_page]>]>
    - define page <server.flag[juggernaut_maps].keys.get[<[pageMin]>].to[<[pageMax]>]>
    - define list <list>
# Fills empty slots with player heads, with page number allowing those later im the list access
    - foreach <[page]>:
        - define item <server.flag[juggernaut_maps].deep_get[<[value]>.display_item]>
        - adjust def:item display_name:<&f><&l><server.flag[juggernaut_maps].deep_get[<[value]>.display_name].parse_color>
        - adjust def:item flag:map:<[value]>
        - choose <server.flag[juggernaut_maps.<[value]>.game_data.phase]>:
            - case -1:
                - define phase <&c>Closed
            - case 0:
                - define phase <&a>Waiting
            - case 1:
                - define phase <&e>Starting
            - case 2:
                - define phase <&d>Ongoing
        - if <server.flag[juggernaut_maps.<[value]>.game_data.phase]> == 0 || <server.flag[juggernaut_maps.<[value]>.game_data.phase]> == 1:
            - define click_type <&e>Left<&sp>Click:<&sp><&7>Join<&sp>Game
        - if <server.flag[juggernaut_maps.<[value]>.game_data.phase]> == 2:
            - if <player.flag[juggernaut_rejoin.id]> == <server.flag[juggernaut_maps.<[value]>.game_data.id]>:
                - define click_type <&e>Left<&sp>Click:<&sp><&7>Rejoin<&sp>Game<&nl><&e>Right<&sp>Click:<&sp><&7>Spectate<&sp>Game
            - else:
                - define click_type <&e>Right<&sp>Click:<&sp><&7>Spectate<&sp>Game
        - if <server.flag[juggernaut_maps.<[value]>.game_data.players].keys.size.if_null[0]> != 1:
            - define players Players
        - else:
            - define players Player
        - adjust def:item lore:<&7><server.flag[juggernaut_maps.<[value]>.game_data.players].keys.size.if_null[0]><&sp><[players]><&nl><[phase]><&nl><&nl><[click_type]>
        - define list <[list].include[<[item]>]>
    - repeat <[size].sub[<[page].size>]>:
        - define list:->:air
    - if <player.flag[gui_page]> > 1:
        - define list <[list].include[jug_prev_page_item[flag=menu:jug_map_selection_gui]]>
    - else:
        - define list <[list].include[black_stained_glass_pane[display_name=<&sp>]]>
    - if <server.flag[juggernaut_maps].keys.get[<[pageMax].add[1]>].exists>:
        - define list <[list].include[jug_next_page_item[flag=menu:jug_map_selection_gui]]>
    - else:
        - define list <[list].include[black_stained_glass_pane[display_name=<&sp>]]>
    - determine <[list]>
  slots:
    - [g] [g] [g] [g] [g] [g] [g] [g] [g]
    - [g] [] [] [] [] [] [] [] [g]
    - [g] [] [] [] [] [] [] [] [g]
    - [g] [] [] [] [] [] [] [] [g]
    - [g] [] [] [] [] [] [] [] [g]
    - [] [g] [g] [g] [t] [g] [g] [g] []
jug_page_proc:
    type: procedure
    definitions: size
    script:
    - narrate <[size]>
jug_inv_click:
    type: world
    events:
        on player left clicks item_flagged:map in jug_map_selection_gui:
        - define map <context.item.flag[map]>
        - if <player.has_flag[juggernaut_data.in_game]>:
            - narrate "<&c>You are already in a game!"
            - stop
        - if <server.flag[juggernaut_maps.<[map]>.game_data.phase]> <= 1 && <server.flag[juggernaut_maps.<[map]>.game_data.phase]> != -1:
            - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.players.<player>].as[<map[].with[score].as[0].with[score_time].as[<util.time_now>]>]>
            - flag <player> juggernaut_data:<map[].with[map].as[<[map]>].with[ready_spam].as[0].with[leave_spam].as[0].with[in_game].as[true]>
            - teleport <player> to:<server.flag[juggernaut_maps].deep_get[<[map]>.waiting_spawn]>
            - inventory clear d:<player.inventory>
            - heal
            - feed <player> amount:20
            - adjust <player> invulnerable:true
            - inventory set d:<player.inventory> o:jug_waiting_leave slot:9
            - inventory set d:<player.inventory> o:FIREWORK_STAR[display_name=<&7>Selected<&sp>Kit:<&sp><&l>Random] slot:5
            - inventory set d:<player.inventory> o:jug_waiting_ready slot:2
            - inventory set d:<player.inventory> o:jug_waiting_kit slot:1
            - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.countdown].as[<server.flag[juggernaut_maps].deep_get[<[map]>.game_data.saved_countdown]>]>
            - run jug_ready_xp def:<[map]>
            - if <server.flag[juggernaut_maps].deep_get[<[map]>.game_data.players].keys.size> >= <yaml[juggernaut].read[mininum_players]> && <server.flag[juggernaut_maps].deep_get[<[map]>.game_data.phase]> == 0:
                - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.phase].as[1]>
                - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.countdown].as[61]>
                - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.saved_countdown].as[61]>
                - foreach <server.flag[juggernaut_maps].deep_get[<[map]>.game_data.players].keys>:
                    - run jug_ready_xp def:<[map]>
                - while <server.flag[juggernaut_maps].deep_get[<[map]>.game_data.countdown]> > 0:
                    - if <server.flag[juggernaut_maps].deep_get[<[map]>.game_data.phase]> == 1:
                        - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.countdown].as[<server.flag[juggernaut_maps].deep_get[<[map]>.game_data.countdown].sub[1]>]>
                        - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.saved_countdown].as[<server.flag[juggernaut_maps].deep_get[<[map]>.game_data.saved_countdown].sub[1]>]>
                        - foreach <server.flag[juggernaut_maps].deep_get[<[map]>.game_data.players].keys>:
                            - run jug_ready_xp def:<[map]>
                        - if <server.flag[juggernaut_maps].deep_get[<[map]>.game_data.countdown]> <= 10 && <server.flag[juggernaut_maps].deep_get[<[map]>.game_data.countdown]> > 0:
                            - playsound <server.flag[juggernaut_maps].deep_get[<[map]>.game_data.players].keys> sound:BLOCK_TRIPWIRE_CLICK_ON pitch:0.0
                        - else if <server.flag[juggernaut_maps].deep_get[<[map]>.game_data.countdown]> == 0:
                            - playsound <server.flag[juggernaut_maps].deep_get[<[map]>.game_data.players].keys> sound:ENTITY_PLAYER_LEVELUP pitch:1.0
                            - flag server juggernaut_maps.<[map]>.game_data.phase:2
                            - flag server juggernaut_maps.<[map]>.game_data.id:<util.random.uuid>
                            - teleport <server.flag[juggernaut_maps.<[map]>.game_data.players].keys> to:<server.flag[juggernaut_maps.<[map]>.spawn]>
                            - define juggernaut <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.random>
                            - flag server juggernaut_maps.<[map]>.game_data.juggernaut:<[juggernaut]>
                            - flag <[juggernaut]> juggernaut_data.is_juggernaut:true
                            - title 'title:<&c>You are the Juggernaut!' player:<[juggernaut]>
                            - cast glowing duration:10000s <[juggernaut]> no_icon no_particles
                            - teleport <[juggernaut]> to:<server.flag[juggernaut_maps.<[map]>.jug_spawn]>
                            - flag server juggernaut_maps.<[map]>.game_data.countdown:!
                            - flag server juggernaut_maps.<[map]>.game_data.saved_countdown:!
                            - flag server juggernaut_maps.<[map]>.game_data.ready_players:<list[]>
                            - foreach <yaml[juggernaut].read[victory_conditions].keys.sort_by_number[].reverse>:
                                - if <[value]> <= <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size>:
                                    - flag server juggernaut_maps.<[map]>.game_data.victory_condition:<yaml[juggernaut].read[victory_conditions.<[value]>]>
                                    - foreach stop
                            - run jug_update_sidebar def:<[map]>|on
                            - foreach <server.flag[juggernaut_maps.<[map]>.game_data.players].keys>:
                                - cast damage_resistance duration:<yaml[juggernaut].read[spawn_protection_duration]> amplifier:<yaml[juggernaut].read[spawn_protection_level].sub[1]> player:<[value]>
                                - run jug_give_kit player:<[value]>
                                - adjust <[value]> invulnerable:false
                        - wait 1s
                    - else:
                        - stop
        - else if <player.flag[juggernaut_rejoin.id]> == <server.flag[juggernaut_maps.<[map]>.game_data.id]>:
            - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.players.<player>].as[<map[].with[score].as[<player.flag[juggernaut_rejoin.score]>].with[score_time].as[<player.flag[juggernaut_rejoin.score_time]>]>]>
            - flag <player> juggernaut_data:<map[].with[map].as[<[map]>].with[ready_spam].as[0].with[leave_spam].as[0].with[in_game].as[true]>
            - inventory clear d:<player.inventory>
            - run jug_update_sidebar def:<[map]>|on
            - teleport <player> to:<server.flag[juggernaut_maps.<[map]>.spawn]>
            - heal <player>
            - feed <player> amount:20
            - flag <player> juggernaut_data.dead:true
            - flag <player> juggernaut_data.dead_countdown:true
            - flag <player> juggernaut_data.kit_selection:true
            - flag <player> juggernaut_data.last_damager:!
            - flag <player> juggernaut_data.hidden_from:<server.flag[juggernaut_maps.<[map]>.game_data.players].keys>
            - adjust <player> hide_from_players:<player.flag[juggernaut_data.hidden_from]>
            - adjust <player> can_fly:true
            - adjust <player> invulnerable:true
            - adjust <player> clear_body_arrows
            - inventory clear d:<player.inventory>
            - flag <player> gui_page:1
            - inventory open d:JUG_KIT_SELECTION_GUI
            - inventory set d:<player.inventory> o:jug_waiting_kit slot:1
            - inventory set d:<player.inventory> o:<yaml[juggernaut].read[kits.<player.flag[juggernaut_data.kit]>.gui_item]>[display_name=<&7>Selected<&sp>Kit:<&sp><&color[#<yaml[juggernaut].read[kits.<player.flag[juggernaut_data.kit]>.primary_color]>]><&l><yaml[juggernaut].read[kits.<player.flag[juggernaut_data.kit]>.display_name]>] slot:5
            - adjust <player> fake_experience:1|<yaml[juggernaut].read[respawn_timer].round>
            - repeat <yaml[juggernaut].read[respawn_timer].round>:
                - if <player.has_flag[juggernaut_data.in_game]>:
                    - adjust <player> fake_experience:<[value].sub[11].abs.div[10]>|<[value].sub[11].abs>
                    - wait 1s
                - else:
                    - stop
            - if <player.has_flag[juggernaut_data.in_game]>:
                - adjust <player> fake_experience
                - flag <player> juggernaut_data.dead_countdown:!
                - if !<player.has_flag[juggernaut_data.kit_selection]>:
                    - run jug_respawn_script player:<player>
        on player right clicks item_flagged:map in jug_map_selection_gui:
        - define map <context.item.flag[map]>
        - if <player.has_flag[juggernaut_data.in_game]>:
            - narrate "<&c>You are already in a game!"
            - stop
        - if <server.flag[juggernaut_maps.<[map]>.game_data.phase]> == 2:
            - flag server juggernaut_maps.<[map]>.game_data.spectators:->:<player>
            - flag <player> juggernaut_data:<map[].with[map].as[<[map]>].with[spectator].as[true].with[in_game].as[true]>
            - flag <player> juggernaut_data.hidden_from:<server.flag[juggernaut_maps.<[map]>.game_data.players].keys>
            - adjust <player> hide_from_players:<player.flag[juggernaut_data.hidden_from]>
            - adjust <player> can_fly:true
            - adjust <player> invulnerable:true
            - teleport <player> to:<server.flag[juggernaut_maps.<[map]>.spawn]>
            - inventory clear d:<player.inventory>
            - inventory set d:<player.inventory> o:jug_waiting_leave slot:9
            - inventory set d:<player.inventory> o:jug_player_compass slot:1
            - heal
            - run jug_sidebar_display
        on player clicks jug_tutorial_item in jug_map_selection_gui:
            - run jug_tutorial def:intro
            - inventory close d:<player.inventory>
        on player flagged:juggernaut_data.in_game clicks item in player*:
            - determine passively cancelled
        on player flagged:juggernaut_rejoin joins:
        - define map <player.flag[juggernaut_rejoin.map]>
        - if <player.flag[juggernaut_rejoin.id]> == <server.flag[juggernaut_maps.<[map]>.game_data.id]>:
            - clickable jug_rejoin_task def:<[map]> player:<player> save:rejoin until:30s
            - narrate "<&7>Click <&a><&l><element[[here]].on_click[<entry[rejoin].command>]> <&7>to rejoin the Juggernaut game!"
jug_rejoin_task:
    type: task
    definitions: map
    script:
    - if <player.flag[juggernaut_rejoin.id]> != <server.flag[juggernaut_maps.<[map]>.game_data.id]>:
        - narrate "<&c>The match you left ended!"
        - stop
    - if <player.has_flag[juggernaut_data.in_game]>:
        - narrate "<&c>You can't rejoin a match from within one!"
        - stop
    - if <player.location.world> != <server.flag[juggernaut_spawn].world>:
        - narrate "<&c>You must be in the same world as Juggernaut to rejoin!"
        - stop
    - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.players.<player>].as[<map[].with[score].as[<player.flag[juggernaut_rejoin.score]>].with[score_time].as[<player.flag[juggernaut_rejoin.score_time]>]>]>
    - flag <player> juggernaut_data:<map[].with[map].as[<[map]>].with[ready_spam].as[0].with[leave_spam].as[0].with[in_game].as[true]>
    - inventory clear d:<player.inventory>
    - run jug_update_sidebar def:<[map]>|on
    - teleport <player> to:<server.flag[juggernaut_maps.<[map]>.spawn]>
    - heal <player>
    - feed <player> amount:20
    - flag <player> juggernaut_data.dead:true
    - flag <player> juggernaut_data.dead_countdown:true
    - flag <player> juggernaut_data.kit_selection:true
    - flag <player> juggernaut_data.last_damager:!
    - flag <player> juggernaut_data.hidden_from:<server.flag[juggernaut_maps.<[map]>.game_data.players].keys>
    - adjust <player> hide_from_players:<player.flag[juggernaut_data.hidden_from]>
    - adjust <player> can_fly:true
    - adjust <player> invulnerable:true
    - adjust <player> clear_body_arrows
    - inventory clear d:<player.inventory>
    - flag <player> gui_page:1
    - inventory open d:JUG_KIT_SELECTION_GUI
    - inventory set d:<player.inventory> o:jug_waiting_kit slot:1
    - inventory set d:<player.inventory> o:<yaml[juggernaut].read[kits.<player.flag[juggernaut_data.kit]>.gui_item]>[display_name=<&7>Selected<&sp>Kit:<&sp><&color[#<yaml[juggernaut].read[kits.<player.flag[juggernaut_data.kit]>.primary_color]>]><&l><yaml[juggernaut].read[kits.<player.flag[juggernaut_data.kit]>.display_name]>] slot:5
    - adjust <player> fake_experience:1|<yaml[juggernaut].read[respawn_timer].round>
    - repeat <yaml[juggernaut].read[respawn_timer].round>:
        - if <player.has_flag[juggernaut_data.in_game]>:
            - adjust <player> fake_experience:<[value].sub[11].abs.div[10]>|<[value].sub[11].abs>
            - wait 1s
        - else:
            - stop
    - if <player.has_flag[juggernaut_data.in_game]>:
        - adjust <player> fake_experience
        - flag <player> juggernaut_data.dead_countdown:!
        - if !<player.has_flag[juggernaut_data.kit_selection]>:
            - run jug_respawn_script player:<player>
jug_kill_script:
    type: world
    events:
        on player flagged:juggernaut_data.in_game damaged:
        - if <context.damager.exists>:
            - if <context.damager.has_flag[juggernaut_data.is_juggernaut]> || <context.entity.has_flag[juggernaut_data.is_juggernaut]>:
                - if !<context.damager.has_flag[juggernaut_data.dead]> && !<context.damager.has_flag[juggernaut_data.spectator]>:
                    - if <context.damager> != <player>:
                        - flag <context.entity> juggernaut_data.last_damager:<context.damager>
                    - if <context.projectile.has_flag[sharpshooter]>:
                        - define ability <yaml[juggernaut].read[kits.<context.damager.flag[juggernaut_data.kit]>.inventory.<context.projectile.flag[kit_item]>.ability]>
                        - if <context.damager.has_flag[juggernaut_data.is_juggernaut]>:
                            - define player_type juggernaut
                        - else:
                            - define player_type player
                        - define maxDis <[ability.max_distance.<[player_type]>].if_null[<[ability.max_distance]>]>
                        - define minDam <[ability.min_damage_multiplier.<[player_type]>].if_null[<[ability.min_damage_multiplier]>]>
                        - define maxDam <[ability.max_damage_multiplier.<[player_type]>].if_null[<[ability.max_damage_multiplier]>]>
                        - define damageMultiplier <context.projectile.flag[shot_origin].distance[<context.entity.location>].div[<[maxDis].div[<[maxDam].sub[<[minDam]>]>]>].add[<[minDam]>].min[<[maxDam]>]>
                        - narrate "<&7>You dealt <&a><&l><[damageMultiplier].round_to_precision[0.01].substring[1,<[damageMultiplier].round_to_precision[0.01].index_of[.].add[2]>]>x <&7>more damage!"
                    - if <context.entity.has_flag[juggernaut_data.is_juggernaut]>:
                        - determine <context.final_damage.mul[<[damageMultiplier].if_null[1]>].mul[<proc[jug_jug_res_proc].context[<player.flag[juggernaut_data.map]>|<context.cause>]>]>
                    - else:
                        - determine <context.final_damage.mul[<[damageMultiplier].if_null[1]>]>
                - else:
                    - determine passively cancelled
            - else:
                - determine passively cancelled
        on player flagged:juggernaut_data.in_game shoots item_flagged:projectile_damage:
        - determine passively KEEP_ITEM
        - adjust <context.projectile> damage:<context.bow.flag[projectile_damage]>
        - if <context.bow.flag[ability_charge]> == sharpshooter:
            - if <player.item_in_hand> == <context.bow>:
                - inventory adjust slot:<player.held_item_slot> flag:ability_charge:!
                - inventory adjust slot:<player.held_item_slot> remove_enchantments:<list[].include[luck]>
            - else:
                - inventory adjust slot:41 flag:ability_charge:!
                - inventory adjust slot:41 remove_enchantments:<list[].include[luck]>
            - flag <context.projectile> sharpshooter:true
            - flag <context.projectile> kit_item:<context.bow.flag[kit_item]>
            - flag <context.projectile> shot_origin:<player.location>
        on player flagged:juggernaut_data.in_game changes food level:
        - determine 20
        on player flagged:juggernaut_data.in_game dies:
        - if <context.entity.has_flag[juggernaut_data.dead]> || <context.entity.has_flag[juggernaut_data.spectator]>:
            - determine passively cancelled
            - stop
        - if <server.flag[juggernaut_maps.<context.entity.flag[juggernaut_data.map]>.game_data.phase]> != 2:
            - determine passively cancelled
            - stop
        - define map <context.entity.flag[juggernaut_data.map]>
        - if <context.damager.exists> && <context.damager> != <context.entity> && <context.damager.is_player>:
            - if <context.damager.has_flag[juggernaut_data.is_juggernaut]>:
                - flag server juggernaut_maps.<[map]>.game_data.players.<context.damager>.score:+:<yaml[juggernaut].read[juggernaut_kill_points]>
                - flag server juggernaut_maps.<[map]>.game_data.players.<context.damager>.score_time:<util.time_now>
                - narrate "<yaml[juggernaut].read[chat_prefix].parse_color> <&e><context.entity.name> <&7>was killed by <&c><context.damager.name>" targets:<proc[jug_viewers].context[<[map]>]>
                - narrate "<yaml[juggernaut].read[chat_prefix].parse_color> <&c><context.damager.name> <&7>now has <&a><server.flag[juggernaut_maps.<[map]>.game_data.players.<context.damager>.score]> <&7>points" targets:<proc[jug_viewers].context[<[map]>]>
                - run jug_update_sidebar def:<[map]>|on|<context.damager>
            - else if <context.entity.has_flag[juggernaut_data.is_juggernaut]>:
                - flag server juggernaut_maps.<[map]>.game_data.players.<context.damager>.score:+:<yaml[juggernaut].read[kill_juggernaut_points]>
                - flag server juggernaut_maps.<[map]>.game_data.players.<context.damager>.score_time:<util.time_now>
                - flag server juggernaut_maps.<[map]>.game_data.juggernaut:<context.damager>
                - flag <context.entity> juggernaut_data.is_juggernaut:!
                - flag <context.damager> juggernaut_data.is_juggernaut:true
                - cast glowing remove <context.entity>
                - if !<context.damager.has_flag[juggernaut_data.invis]>:
                    - narrate <context.damager.has_flag[juggernaut_data.invis]>|<context.damager.flag[juggernaut_data.invis]>
                    - cast glowing duration:10000s <context.damager> no_icon no_particles
                - narrate "<yaml[juggernaut].read[chat_prefix].parse_color> <&c><context.entity.name> <&7>was killed by <&e><context.damager.name>" targets:<proc[jug_viewers].context[<[map]>]>
                - narrate "<yaml[juggernaut].read[chat_prefix].parse_color> <&c><context.damager.name> <&7>is now the juggernaut! They now have <&a><server.flag[juggernaut_maps.<[map]>.game_data.players.<context.damager>.score]> <&7>points" targets:<proc[jug_viewers].context[<[map]>]>
                - title 'title:<&c>You are now the Juggernaut!' targets:<context.damager>
                - run jug_update_sidebar def:<[map]>|on|<context.damager>
        - else if <context.entity.has_flag[juggernaut_data.is_juggernaut]>:
            - if <context.entity.flag[juggernaut_data.last_damager].exists> && <context.entity.flag[juggernaut_data.last_damager]> != <context.entity> && <context.entity.flag[juggernaut_data.last_damager].is_player>:
                - define killer <context.entity.flag[juggernaut_data.last_damager]>
                - flag server juggernaut_maps.<[map]>.game_data.players.<[killer]>.score:+:<yaml[juggernaut].read[kill_juggernaut_points]>
                - flag server juggernaut_maps.<[map]>.game_data.players.<[killer]>.score_time:<util.time_now>
                - flag server juggernaut_maps.<[map]>.game_data.juggernaut:<[killer]>
                - flag <context.entity> juggernaut_data.is_juggernaut:!
                - flag <[killer]> juggernaut_data.is_juggernaut:true
                - cast glowing remove <context.entity>
                - if !<[killer].has_flag[juggernaut_data.invis]>:
                    - cast glowing duration:10000s <[killer]> no_icon no_particles
                - narrate "<yaml[juggernaut].read[chat_prefix].parse_color> <&c><context.entity.name> <&7>was killed by <&e><[killer].name>" targets:<proc[jug_viewers].context[<[map]>]>
                - narrate "<yaml[juggernaut].read[chat_prefix].parse_color> <&c><[killer].name> <&7>is now the juggernaut! They now have <&a><server.flag[juggernaut_maps.<[map]>.game_data.players.<[killer]>.score]> <&7>points" targets:<proc[jug_viewers].context[<[map]>]>
                - title 'title:<&c>You are now the Juggernaut!' targets:<[killer]>
                - run jug_update_sidebar def:<[map]>|on|<[killer]>
            - else if <context.entity.location.find_entities[player].within[300].filter_tag[<[filter_value].has_flag[juggernaut_data.in_game].and[<[filter_value].has_flag[juggernaut_data.dead].not.and[<[filter_value].equals[<context.entity>].not.and[<[filter_value].has_flag[juggernaut_data.spectator].not>]>]>]>].first.exists>:
                - define killer <context.entity.location.find_entities[player].within[300].filter_tag[<[filter_value].has_flag[juggernaut_data.in_game].and[<[filter_value].has_flag[juggernaut_data.dead].not.and[<[filter_value].equals[<context.entity>].not.and[<[filter_value].has_flag[juggernaut_data.spectator].not>]>]>]>].first>
                - flag server juggernaut_maps.<[map]>.game_data.players.<[killer]>.score:+:<yaml[juggernaut].read[kill_juggernaut_points]>
                - flag server juggernaut_maps.<[map]>.game_data.players.<[killer]>.score_time:<util.time_now>
                - flag server juggernaut_maps.<[map]>.game_data.juggernaut:<[killer]>
                - flag <context.entity> juggernaut_data.is_juggernaut:!
                - flag <[killer]> juggernaut_data.is_juggernaut:true
                - cast glowing remove <context.entity>
                - if !<[killer].has_flag[juggernaut_data.invis]>:
                    - cast glowing duration:10000s <[killer]> no_icon no_particles
                - narrate "<yaml[juggernaut].read[chat_prefix].parse_color> <&c><context.entity.name> <&7>died!" targets:<proc[jug_viewers].context[<[map]>]>
                - narrate "<yaml[juggernaut].read[chat_prefix].parse_color> <&c><[killer].name> <&7>is now the juggernaut! They now have <&a><server.flag[juggernaut_maps.<[map]>.game_data.players.<[killer]>.score]> <&7>points" targets:<proc[jug_viewers].context[<[map]>]>
                - title 'title:<&c>You are now the Juggernaut!' targets:<[killer]>
                - run jug_update_sidebar def:<[map]>|on|<[killer]>
            - else:
                - narrate "<yaml[juggernaut].read[chat_prefix].parse_color> <&c><context.entity.name> <&7>died!" targets:<proc[jug_viewers].context[<[map]>]>
        - else:
            - narrate "<yaml[juggernaut].read[chat_prefix].parse_color> <&e><context.entity.name> <&7>died!" targets:<proc[jug_viewers].context[<[map]>]>
        - teleport <context.entity> to:<server.flag[juggernaut_maps.<[map]>.spawn]>
        - heal <context.entity>
        - determine passively cancelled
        - if <context.entity.has_flag[juggernaut_data.in_game]>:
            - flag <context.entity> juggernaut_data.dead:true
            - flag <context.entity> juggernaut_data.dead_countdown:true
            - flag <context.entity> juggernaut_data.kit_selection:true
            - flag <context.entity> juggernaut_data.last_damager:!
            - flag <context.entity> juggernaut_data.hidden_from:<server.flag[juggernaut_maps.<[map]>.game_data.players].keys>
            - adjust <context.entity> hide_from_players:<player.flag[juggernaut_data.hidden_from]>
            - adjust <context.entity> can_fly:true
            - adjust <player> invulnerable:true
            - adjust <context.entity> clear_body_arrows
            - inventory clear d:<context.entity.inventory>
            - flag <player> gui_page:1
            - inventory open d:JUG_KIT_SELECTION_GUI
            - inventory set d:<context.entity.inventory> o:jug_waiting_kit slot:1
            - inventory set d:<player.inventory> o:<yaml[juggernaut].read[kits.<player.flag[juggernaut_data.kit]>.gui_item]>[display_name=<&7>Selected<&sp>Kit:<&sp><&color[#<yaml[juggernaut].read[kits.<player.flag[juggernaut_data.kit]>.primary_color]>]><&l><yaml[juggernaut].read[kits.<player.flag[juggernaut_data.kit]>.display_name]>] slot:5
            - adjust <context.entity> fake_experience:1|<yaml[juggernaut].read[respawn_timer].round>
            - repeat <yaml[juggernaut].read[respawn_timer].round>:
                - if <context.entity.has_flag[juggernaut_data.in_game]>:
                    - adjust <context.entity> fake_experience:<[value].sub[11].abs.div[10]>|<[value].sub[11].abs>
                    - wait 1s
                - else:
                    - stop
            - if <context.entity.has_flag[juggernaut_data.in_game]>:
                - adjust <context.entity> fake_experience
                - flag <context.entity> juggernaut_data.dead_countdown:!
                - if !<context.entity.has_flag[juggernaut_data.kit_selection]>:
                    - run jug_respawn_script player:<context.entity>
jug_respawn_script:
    type: task
    script:
    - flag <player> juggernaut_data.dead:!
    - adjust <player> show_to_players:<player.flag[juggernaut_data.hidden_from]>
    - flag <player> juggernaut_data.hidden_from:!
    - adjust <player> can_fly:false
    - adjust <player> fall_distance:0
    - adjust <player> invulnerable:false
    - adjust <player> fake_experience
    - teleport <player> to:<server.flag[juggernaut_maps.<player.flag[juggernaut_data.map]>.spawn]>
    - run jug_give_kit
    - cast damage_resistance duration:5 amplifier:2
particle_example:
    type: task
    script:
    - repeat 60:
        - playeffect effect:villager_happy at:<player.eye_location.forward[<[value].mul[0.2]>]> offset:0,0,0
        - hurt 5 <player.eye_location.forward[<[value].mul[0.2]>].find_entities[player].within[0.01]> source:<player> cause:ENTITY_ATTACK
jug_leave_lobby:
    type: world
    events:
        on player right clicks block with:jug_waiting_leave:
        - run jug_remove_player def:<player.flag[juggernaut_data].get[map]>
        on player flagged:juggernaut_data.in_game quits:
        - run jug_remove_player def:<player.flag[juggernaut_data].get[map]>
        on server start:
        - foreach <server.flag[juggernaut_maps]>:
            - run jug_stop_game def:<[key]>
        on player right clicks block with:jug_waiting_kit:
        - if !<player.has_flag[juggernaut_data.kit_selection]>:
            - flag <player> gui_page:1
            - inventory open d:JUG_KIT_SELECTION_GUI
        on player right clicks block with:jug_waiting_ready:
        - if <player.flag[juggernaut_data].get[ready_spam]> < <yaml[juggernaut].read[ready_spam_limit]>:
            - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<player.flag[juggernaut_data].get[map]>.game_data.ready_players].as[<server.flag[juggernaut_maps].deep_get[<player.flag[juggernaut_data].get[map]>.game_data.ready_players].include[<player>]>]>
            - run jug_ready_xp def:<player.flag[juggernaut_data].get[map]>
            - narrate "<&a><player.name> is ready! (<server.flag[juggernaut_maps].deep_get[<player.flag[juggernaut_data].get[map]>.game_data.ready_players].size>/<server.flag[juggernaut_maps].deep_get[<player.flag[juggernaut_data].get[map]>.game_data.players].keys.size>)" targets:<server.flag[juggernaut_maps].deep_get[<player.flag[juggernaut_data].get[map]>.game_data.players].keys>
            - if <server.flag[juggernaut_maps].deep_get[<player.flag[juggernaut_data].get[map]>.game_data.ready_players].size> == <server.flag[juggernaut_maps].deep_get[<player.flag[juggernaut_data].get[map]>.game_data.players].keys.size> && <server.flag[juggernaut_maps].deep_get[<player.flag[juggernaut_data].get[map]>.game_data.saved_countdown]> > 3:
                - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<player.flag[juggernaut_data].get[map]>.game_data.countdown].as[3]>
                - run jug_ready_xp def:<player.flag[juggernaut_data].get[map]>
                - playsound <server.flag[juggernaut_maps].deep_get[<player.flag[juggernaut_data].get[map]>.game_data.players].keys> sound:BLOCK_NOTE_BLOCK_PLING pitch:2.0
            - else:
                - playsound <server.flag[juggernaut_maps].deep_get[<player.flag[juggernaut_data].get[map]>.game_data.players].keys> sound:BLOCK_NOTE_BLOCK_PLING pitch:1.0 volume:0.25
            - wait 1t
            - inventory set d:<player.inventory> o:jug_waiting_unready slot:2
            - flag <player> juggernaut_data.ready_spam:+:1
            - wait <yaml[juggernaut].read[ready_spam_rate]>s
            - if <player.flag[juggernaut_data.ready_spam].exists>:
                - flag <player> juggernaut_data.ready_spam:-:1
        - else:
            - narrate "<&c>Please slow down!"
        on player right clicks block with:jug_waiting_unready:
        - if <player.flag[juggernaut_data].get[ready_spam]> < <yaml[juggernaut].read[ready_spam_limit]>:
            - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<player.flag[juggernaut_data].get[map]>.game_data.ready_players].as[<server.flag[juggernaut_maps].deep_get[<player.flag[juggernaut_data].get[map]>.game_data.ready_players].exclude[<player>]>]>
            - narrate "<&c><player.name> is no longer ready. (<server.flag[juggernaut_maps].deep_get[<player.flag[juggernaut_data].get[map]>.game_data.ready_players].size>/<server.flag[juggernaut_maps].deep_get[<player.flag[juggernaut_data].get[map]>.game_data.players].keys.size>)" targets:<server.flag[juggernaut_maps].deep_get[<player.flag[juggernaut_data].get[map]>.game_data.players].keys>
            - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<player.flag[juggernaut_data].get[map]>.game_data.countdown].as[<server.flag[juggernaut_maps].deep_get[<player.flag[juggernaut_data].get[map]>.game_data.saved_countdown]>]>
            - run jug_ready_xp def:<player.flag[juggernaut_data].get[map]>
            - playsound <server.flag[juggernaut_maps].deep_get[<player.flag[juggernaut_data].get[map]>.game_data.players].keys> sound:BLOCK_NOTE_BLOCK_PLING pitch:0.0 volume:0.25
            - wait 1t
            - inventory set d:<player.inventory> o:jug_waiting_ready slot:2
            - flag <player> juggernaut_data.ready_spam:+:1
            - wait <yaml[juggernaut].read[ready_spam_rate]>s
            - if <player.flag[juggernaut_data.ready_spam].exists>:
                - flag <player> juggernaut_data.ready_spam:-:1
        - else:
            - narrate "<&c>Please slow down!"
jug_remove_player:
    type: task
    definitions: map
    script:
    - if !<player.has_flag[juggernaut_data.spectator]>:
        - define rejoin_data <map[]>
        - define rejoin_data.id:<server.flag[juggernaut_maps.<[map]>.game_data.id]>
        - define rejoin_data.map:<[map]>
        - define rejoin_data.score:<server.flag[juggernaut_maps.<[map]>.game_data.players.<player>.score]>
        - define rejoin_data.score_time:<server.flag[juggernaut_maps.<[map]>.game_data.players.<player>.score_time]>
        - flag <player> juggernaut_rejoin:<[rejoin_data]>
    - if <server.flag[juggernaut_maps.<[map]>.game_data.ready_players].size> > 0:
        - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.ready_players].as[<server.flag[juggernaut_maps].deep_get[<[map]>.game_data.ready_players].exclude[<player>]>]>
    - if <server.flag[juggernaut_maps.<[map]>.game_data.players].contains[<player>]>:
        - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_exclude[<[map]>.game_data.players.<player>]>
    - else if <server.flag[juggernaut_maps.<[map]>.game_data.spectators].contains[<player>]>:
        - flag server juggernaut_maps.<[map]>.game_data.spectators:<-:<player>
    - adjust <player> show_to_players:<player.flag[juggernaut_data.hidden_from]>
    - adjust <player> can_fly:false
    - adjust <player> invulnerable:false
    - if <player.has_flag[juggernaut_data.is_juggernaut]> && <server.flag[juggernaut_maps.<[map]>.game_data.phase]> >= 2 && <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size> > 0:
        - if <player.flag[juggernaut_data.last_damager].exists> && <player.flag[juggernaut_data.last_damager]> != <player> && <player.flag[juggernaut_data.last_damager].is_player>:
            - define killer <player.flag[juggernaut_data.last_damager]>
            - flag server juggernaut_maps.<[map]>.game_data.players.<[killer]>.score:+:<yaml[juggernaut].read[kill_juggernaut_points]>
            - flag server juggernaut_maps.<[map]>.game_data.players.<[killer]>.score_time:<util.time_now>
            - flag server juggernaut_maps.<[map]>.game_data.juggernaut:<[killer]>
            - flag <player> juggernaut_data.is_juggernaut:!
            - flag <[killer]> juggernaut_data.is_juggernaut:true
            - cast glowing remove <player>
            - if !<[killer].has_flag[juggernaut_data.invis]>:
                - cast glowing duration:10000s <[killer]> no_icon no_particles
            - narrate "<yaml[juggernaut].read[chat_prefix].parse_color> <&c><player.name> <&7>left the match!" targets:<proc[jug_viewers].context[<[map]>]>
            - narrate "<yaml[juggernaut].read[chat_prefix].parse_color> <&c><[killer].name> <&7>is now the juggernaut! They now have <&a><server.flag[juggernaut_maps.<[map]>.game_data.players.<[killer]>.score]> <&7>points" targets:<proc[jug_viewers].context[<[map]>]>
            - title 'title:<&c>You are now the Juggernaut!' targets:<[killer]>
            - run jug_update_sidebar def:<[map]>|on|<[killer]>
        - else if <player.location.find_entities[player].within[300].filter_tag[<[filter_value].has_flag[juggernaut_data.in_game].and[<[filter_value].has_flag[juggernaut_data.dead].not.and[<[filter_value].equals[<player>].not.and[<[filter_value].has_flag[juggernaut_data.spectator].not>]>]>]>].first.exists>:
            - define killer <player.location.find_entities[player].within[300].filter_tag[<[filter_value].has_flag[juggernaut_data.in_game].and[<[filter_value].has_flag[juggernaut_data.dead].not.and[<[filter_value].equals[<player>].not.and[<[filter_value].has_flag[juggernaut_data.spectator].not>]>]>]>].first>
            - flag server juggernaut_maps.<[map]>.game_data.players.<[killer]>.score:+:<yaml[juggernaut].read[kill_juggernaut_points]>
            - flag server juggernaut_maps.<[map]>.game_data.players.<[killer]>.score_time:<util.time_now>
            - flag server juggernaut_maps.<[map]>.game_data.juggernaut:<[killer]>
            - flag <player> juggernaut_data.is_juggernaut:!
            - flag <[killer]> juggernaut_data.is_juggernaut:true
            - cast glowing remove <player>
            - if !<[killer].has_flag[juggernaut_data.invis]>:
                - cast glowing duration:10000s <[killer]> no_icon no_particles
            - narrate "<yaml[juggernaut].read[chat_prefix].parse_color> <&c><player.name> <&7>left the match!" targets:<proc[jug_viewers].context[<[map]>]>
            - narrate "<yaml[juggernaut].read[chat_prefix].parse_color> <&c><[killer].name> <&7>is now the juggernaut! They now have <&a><server.flag[juggernaut_maps.<[map]>.game_data.players.<[killer]>.score]> <&7>points" targets:<proc[jug_viewers].context[<[map]>]>
            - title 'title:<&c>You are now the Juggernaut!' targets:<[killer]>
            - run jug_update_sidebar def:<[map]>|on|<[killer]>
        - else if <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.exclude[<player>].exists>:
            - define killer <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.exclude[<player>].random>
            - flag server juggernaut_maps.<[map]>.game_data.players.<[killer]>.score:+:<yaml[juggernaut].read[kill_juggernaut_points]>
            - flag server juggernaut_maps.<[map]>.game_data.players.<[killer]>.score_time:<util.time_now>
            - flag server juggernaut_maps.<[map]>.game_data.juggernaut:<[killer]>
            - flag <player> juggernaut_data.is_juggernaut:!
            - flag <[killer]> juggernaut_data.is_juggernaut:true
            - cast glowing remove <player>
            - if !<[killer].has_flag[juggernaut_data.invis]>:
                - cast glowing duration:10000s <[killer]> no_icon no_particles
            - narrate "<yaml[juggernaut].read[chat_prefix].parse_color> <&c><player.name> <&7>left the match!" targets:<proc[jug_viewers].context[<[map]>]>
            - narrate "<yaml[juggernaut].read[chat_prefix].parse_color> <&c><[killer].name> <&7>is now the juggernaut! They now have <&a><server.flag[juggernaut_maps.<[map]>.game_data.players.<[killer]>.score]> <&7>points" targets:<proc[jug_viewers].context[<[map]>]>
            - title 'title:<&c>You are now the Juggernaut!' targets:<[killer]>
            - run jug_update_sidebar def:<[map]>|on|<[killer]>
        - else:
            - narrate "<yaml[juggernaut].read[chat_prefix].parse_color> <&c><player.name> <&7>left the match!" targets:<proc[jug_viewers].context[<[map]>]>
            - run jug_update_sidebar def:<[map]>|on
    - else if <server.flag[juggernaut_maps.<[map]>.game_data.phase]> >= 2:
        - narrate "<yaml[juggernaut].read[chat_prefix].parse_color> <&e><player.name> <&7>left the match!" targets:<proc[jug_viewers].context[<[map]>]>
        - run jug_update_sidebar def:<[map]>|on
    - flag <player> juggernaut_data:!
    - inventory clear d:<player.inventory>
    - sidebar remove
    - if <server.flag[juggernaut_maps].deep_get[<[map]>.game_data.players].keys.size> < <yaml[juggernaut].read[mininum_players]>:
        - if <server.flag[juggernaut_maps.<[map]>.game_data.phase]> <= 1:
            - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_exclude[<[map]>.game_data.countdown]>
            - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_exclude[<[map]>.game_data.saved_countdown]>
            - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.phase].as[0]>
        - else if <server.flag[juggernaut_maps.<[map]>.game_data.phase]> == 2:
            - run jug_stop_game def:<[map]>
    - adjust <player> fake_experience
    - run jug_ready_xp def:<[map]>
    - teleport <player> to:<server.flag[juggernaut_spawn]>
    - cast remove glowing
    - cast remove invisibility
    - cast remove resistance
    - wait 1t
    - teleport <player> to:<server.flag[juggernaut_spawn]>
    - flag <player> juggernaut_data:!
    - wait 10s
    - if <player.has_flag[juggernaut_data]>:
        - narrate "<&c>ERROR CODE 110: Please report this error to staff with the error code and this data: <player.flag[juggernaut_data]>"
jug_stop_game:
    type: task
    definitions: map|win
    script:
    - flag server juggernaut_maps.<[map]>.game_data.phase:0
    - if <[win].exists>:
        - foreach <server.flag[juggernaut_maps.<[map]>.game_data.players].keys> as:player:
            - define list <list[]>
            - define list:->:<element[<&a>Final<&sp>scores:]>
            - define sidebarlist <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.sort[jug_sort_players]>
            - foreach <[sidebarlist]>:
                - if <[loop_index]> == 1:
                    - define place <element[<&e><&l>1st<&sp>]>
                - else if <[loop_index]> == 2:
                    - define place <element[<&f><&l>2nd<&sp>]>
                - else if <[loop_index]> == 3:
                    - define place <element[<&color[#aa5500]><&l>3rd<&sp>]>
                - else:
                    - define place <element[<&7><[loop_index]>th<&sp>]>
                - if <[value]> == <[player]>:
                    - define playercolor <&6>
                - else:
                    - define playercolor <&7>
                - define list:->:<element[<[place]><[playercolor]><[value].name>:<&sp><&a><&l><server.flag[juggernaut_maps.<[map]>.game_data.players.<[value]>.score]>]>
            - narrate <[list].separated_by[<&nl>]> targets:<[player]>
    - run jug_update_sidebar def:<[map]>|off
    - foreach <proc[jug_viewers].context[<[map]>]>:
        - run jug_remove_player def:<[value].flag[juggernaut_data].get[map]> player:<[value]>
    - flag server juggernaut_maps.<[map]>.game_data:!
    - flag server juggernaut_maps.<[map]>.game_data.phase:0
    - flag server juggernaut_maps.<[map]>.game_data.ready_players:<list[]>
jug_ready_xp:
    type: task
    definitions: map
    script:
    - define players <server.flag[juggernaut_maps].deep_get[<[map]>.game_data.players].keys>
    - foreach <[players]>:
        - define level <[value].xp_to_next_level>
        - adjust <[value]> fake_experience:<server.flag[juggernaut_maps].deep_get[<[map]>.game_data.ready_players].size.div[<server.flag[juggernaut_maps].deep_get[<[map]>.game_data.players].keys.size>]>|<server.flag[juggernaut_maps].deep_get[<[map]>.game_data.countdown]>
jug_waiting_leave:
    type: item
    material: CLOCK
    display name: <&e>Leave Lobby
    lore:
    - <&7>Right click this item to leave the lobby.
jug_exit_menu_item:
    type: item
    material: ARROW
    display name: <&e><&lt><&lt> Back
jug_prev_page_item:
    type: item
    material: ARROW
    display name: <&e><&lt><&lt> Previous Page
    flags:
        page: -1
jug_next_page_item:
    type: item
    material: ARROW
    display name: <&e> Next Page <&gt><&gt>
    flags:
        page: 1
jug_tutorial_item:
    type: item
    material: PLAYER_HEAD
    mechanisms:
     skull_skin: 937fb91e-562d-4ab3-b495-3c8b183c38bb|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYmFkYzA0OGE3Y2U3OGY3ZGFkNzJhMDdkYTI3ZDg1YzA5MTY4ODFlNTUyMmVlZWQxZTNkYWYyMTdhMzhjMWEifX19
    display name: <&e>Tutorial
jug_player_compass_gui:
  type: inventory
  inventory: CHEST
  title: Player Compass
  size: 54
  gui: true
  debug: false
  definitions:
    g: black_stained_glass_pane[display_name=<&sp>]
  procedural items:
    - define size 28
    - define pageMin <[size].mul[<player.flag[gui_page].sub[1]>].add[1]>
    - define pageMax <[size].mul[<player.flag[gui_page]>]>
    - define page <proc[jug_active_players].context[<player.flag[juggernaut_data.map]>].alphanumeric.get[<[pageMin]>].to[<[pageMax]>]>
    - define list <list>
# Fills empty slots with player heads, with page number allowing those later im the list access
    - foreach <[page]>:
        - define item <item[player_head]>
        - adjust def:item skull_skin:<[value].uuid>
        - adjust def:item display_name:<&e><[value].name>
        - adjust def:item flag:player:<[value]>
        - define list <[list].include[<[item]>]>
    - repeat <[size].sub[<[page].size>]>:
        - define list:->:air
    - if <player.flag[gui_page]> > 1:
        - define list <[list].include[jug_prev_page_item[flag=menu:jug_player_compass_gui]]>
    - else:
        - define list <[list].include[black_stained_glass_pane[display_name=<&sp>]]>
    - if <proc[jug_active_players].context[<player.flag[juggernaut_data.map]>].alphanumeric.get[<[pageMax].add[1]>].exists>:
        - define list <[list].include[jug_next_page_item[flag=menu:jug_player_compass_gui]]>
    - else:
        - define list <[list].include[black_stained_glass_pane[display_name=<&sp>]]>
    - determine <[list]>
  slots:
    - [g] [g] [g] [g] [g] [g] [g] [g] [g]
    - [g] [] [] [] [] [] [] [] [g]
    - [g] [] [] [] [] [] [] [] [g]
    - [g] [] [] [] [] [] [] [] [g]
    - [g] [] [] [] [] [] [] [] [g]
    - [g] [g] [g] [g] [g] [g] [g] [g] [g]
jug_player_compass_click:
    type: world
    events:
        on player clicks item_flagged:player in jug_player_compass_gui:
        - if <context.item.flag[player].has_flag[juggernaut_data.in_game]>:
            - teleport <player> to:<context.item.flag[player].location>
        - else:
            - narrate "<&c>That player is either no longer playing or dead!"
        on player flagged:juggernaut_data.in_game right clicks block with:jug_player_compass bukkit_priority:LOW:
        - determine passively cancelled
        - flag <player> gui_page:1
        - inventory open d:jug_player_compass_gui
jug_player_compass:
    type: item
    material: COMPASS
    display name: <&e>Player Compass
    lore:
    - <&7>Right click this item to view all current players.
jug_waiting_kit:
    type: item
    material: SLIME_BALL
    display name: <&e>Select Kit
    lore:
    - <&7>Right click this item to select a kit.
jug_waiting_ready:
    type: item
    material: GOLD_INGOT
    display name: <&e>Ready Up
    lore:
    - <&7>Right click this item to ready up.
    - <&7>If everyone is ready the game begins sooner.
jug_waiting_unready:
    type: item
    material: GOLD_BLOCK
    display name: <&e>Un-Ready Up
    lore:
    - <&7>Right click this item to un-ready up.
    - <&7>If everyone is ready the game begins sooner.
jug_update_sidebar:
    type: task
    definitions: map|mode|player
    script:
    - if <[mode]> == on:
        - foreach <proc[jug_viewers].context[<[map]>]>:
            - run jug_sidebar_display player:<[value]>
    - else:
        - sidebar remove players:<server.flag[juggernaut_maps.<[map]>.game_data.players].keys>
    - if <server.flag[juggernaut_maps.<[map]>.game_data.players.<[player]>.score]> >= <server.flag[juggernaut_maps.<[map]>.game_data.victory_condition]>:
        - title title:<&e><&l><[player].name><&sp><&a>Wins! targets:<proc[jug_viewers].context[<[map]>]>
        - run jug_stop_game def:<[map]>|true
jug_sidebar_display:
    type: task
    script:
    - define list <list[]>
    - define map <player.flag[juggernaut_data.map]>
    - define list:->:<element[<&4>Juggernaut:<&sp><&c><server.flag[juggernaut_maps.<[map]>.game_data.juggernaut].name>]>
    - define list:->:<element[<&c><&l>---------GOAL:<&sp><server.flag[juggernaut_maps.<[map]>.game_data.victory_condition]>---------]>
    - if <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size> > <yaml[juggernaut].read[sidebar_size]>:
        - define sidebarlist <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.sort[jug_sort_players].get[1].to[<yaml[juggernaut].read[sidebar_size]>]>
        - if <[sidebarlist].contains[<player>]>:
            - define sidebarextra <element[<&7>...]>
        - else:
            - if !<player.has_flag[juggernaut_data.spectator]>:
                - define playerplace <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.sort[jug_sort_players].find[<player>]>
                - if <[playerplace]> == 1:
                    - define place <element[<&e><&l>1st<&sp>]>
                - else if <[playerplace]> == 2:
                    - define place <element[<&f><&l>2nd<&sp>]>
                - else if <[playerplace]> == 3:
                    - define place <element[<&color[#aa5500]><&l>3rd<&sp>]>
                - else:
                    - define place <element[<&7><[playerplace]>th<&sp>]>
                - define sidebarextra <element[<&7>...]>
                - define sidebarextraplayer <element[<[place]><&6><&l>YOU<&sp><player.name>:<&sp><&a><&l><server.flag[juggernaut_maps.<[map]>.game_data.players.<player>.score]>]>
    - else:
        - define sidebarlist <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.sort[jug_sort_players]>
    - foreach <[sidebarlist]>:
        - if <[loop_index]> == 1:
            - define place <element[<&e><&l>1st<&sp>]>
        - else if <[loop_index]> == 2:
            - define place <element[<&f><&l>2nd<&sp>]>
        - else if <[loop_index]> == 3:
            - define place <element[<&color[#aa5500]><&l>3rd<&sp>]>
        - else:
            - define place <element[<&7><[loop_index]>th<&sp>]>
        - if <[value]> == <player>:
            - define playerextra <&6><&l>YOU<&sp>
        - else:
            - define playerextra:!
        - if <server.flag[juggernaut_maps.<[map]>.game_data.players.<[value]>.score]> >= <server.flag[juggernaut_maps.<[map]>.game_data.victory_condition].sub[<yaml[juggernaut].read[kill_juggernaut_points]>]> && !<[value].has_flag[juggernaut_data.is_juggernaut]>:
            - define closeextra <&e><&l>⚠<&sp>
        - else if <server.flag[juggernaut_maps.<[map]>.game_data.players.<[value]>.score]> >= <server.flag[juggernaut_maps.<[map]>.game_data.victory_condition].sub[<yaml[juggernaut].read[juggernaut_kill_points]>]> && <[value].has_flag[juggernaut_data.is_juggernaut]>:
            - define closeextra <&e><&l>⚠<&sp>
        - else:
            - define closeextra:!
        - define list:->:<element[<[closeextra].if_null[]><[place]><[playerextra].if_null[]><&7><[value].name>:<&sp><&a><&l><server.flag[juggernaut_maps.<[map]>.game_data.players.<[value]>.score]>]>
    - if <[sidebarextra].exists>:
        - define list:->:<[sidebarextra]>
    - if <[sidebarextraplayer].exists>:
        - define list:->:<[sidebarextraplayer]>
    - sidebar title:<&c><&l>JUGGERNAUT values:<[list]>
jug_sort_players:
    type: procedure
    definitions: player1|player2
    script:
    - define map <[player1].flag[juggernaut_data.map]>
    - define p1point <server.flag[juggernaut_maps.<[map]>.game_data.players.<[player1]>.score]>
    - define p1time <server.flag[juggernaut_maps.<[map]>.game_data.players.<[player1]>.score_time]>
    - define p2point <server.flag[juggernaut_maps.<[map]>.game_data.players.<[player2]>.score]>
    - define p2time <server.flag[juggernaut_maps.<[map]>.game_data.players.<[player2]>.score_time]>
    - if <[p1point]> > <[p2point]>:
        - determine -1
    - else if <[p1point]> < <[p2point]>:
        - determine 1
    - else if <[p1time].is_before[<[p2time]>]>:
        - determine -1
    - else if <[p2time].is_before[<[p1time]>]>:
        - determine 1
    - else:
        - determine 0
jug_kit_selection_gui:
  type: inventory
  inventory: CHEST
  title: Kits
  size: 54
  gui: true
  debug: false
  definitions:
    g: black_stained_glass_pane[display_name=<&sp>]
  procedural items:
    - define size 28
    - define pageMin <[size].mul[<player.flag[gui_page].sub[1]>].add[1]>
    - define pageMax <[size].mul[<player.flag[gui_page]>]>
    - define pageList <yaml[juggernaut].read[kits].keys.get[<[pageMin]>].to[<[pageMax]>]>
    - foreach <[pageList]>:
        - define page.<[value]>:<yaml[juggernaut].read[kits.<[value]>]>
    - define list <list>
    - foreach <[page]>:
        - define prim <&color[#<[value].get[primary_color]>]>
        - define sec <&color[#<[value].get[secondary_color]>]>
        - define item <[value].get[gui_item].as_item>
        - adjust def:item display_name:<[sec]><&l><&k>;<[prim]><&l><&k>;<[sec]><&l><&k>;<&sp><[prim]><[value].get[display_name]><&sp><[sec]><&l><&k>;<[prim]><&l><&k>;<[sec]><&l><&k>;
        - adjust def:item flag:kit:<[key]>
        - adjust def:item lore:<&7><[value.description].split_lines_by_width[250].replace[<&nl>].with[<&nl><&7>]>
        - adjust def:item hides:all
        - if <[item].flag[kit]> == <player.flag[juggernaut_data.kit]>:
            - adjust def:item enchantments:<map[].with[luck].as[1]>
        - define list:->:<[item]>
    - repeat <element[28].sub[<[list].size>]>:
        - define list:->:air
    - if <player.flag[gui_page]> > 1:
        - define list <[list].include[jug_prev_page_item[flag=menu:jug_kit_selection_gui]]>
    - else:
        - define list <[list].include[black_stained_glass_pane[display_name=<&sp>]]>
    - define item FIREWORK_STAR[display_name=<element[<&c><&l><&k>;<&7><&l><&k>;<&c><&l><&k>;<&sp><&7>Random<&sp>Item<&sp><&c><&l><&k>;<&7><&l><&k>;<&c><&l><&k>;].escaped>;lore=<&7>Chooses<&sp>a<&sp>random<&sp>kit.;flag=kit:random;hides=all]
    - if !<player.has_flag[juggernaut_data.kit]>:
        - define item FIREWORK_STAR[display_name=<element[<&c><&l><&k>;<&7><&l><&k>;<&c><&l><&k>;<&sp><&7>Random<&sp>Item<&sp><&c><&l><&k>;<&7><&l><&k>;<&c><&l><&k>;].escaped>;lore=<&7>Chooses<&sp>a<&sp>random<&sp>kit.;flag=kit:random;hides=all;enchantments=<map[].with[luck].as[1]>]
    - define list:->:<[item]>
    - if <yaml[juggernaut].read[kits].keys.get[<[pageMax].add[1]>].exists>:
        - define list <[list].include[jug_next_page_item[flag=menu:jug_kit_selection_gui]]>
    - else:
        - define list <[list].include[black_stained_glass_pane[display_name=<&sp>]]>
    - determine <[list]>
  slots:
    - [g] [g] [g] [g] [g] [g] [g] [g] [g]
    - [g] [] [] [] [] [] [] [] [g]
    - [g] [] [] [] [] [] [] [] [g]
    - [g] [] [] [] [] [] [] [] [g]
    - [g] [] [] [] [] [] [] [] [g]
    - [] [g] [g] [g] [] [g] [g] [g] []
jug_kit_preview_gui:
  type: inventory
  inventory: CHEST
  title: Kits
  size: 54
  gui: true
  debug: false
  definitions:
    g: black_stained_glass_pane[display_name=<&sp>]
    b: jug_exit_menu_item[flag=menu:jug_kit_selection_gui;display_name=test]
  procedural items:
    - define list <list>
    - define kit_root <yaml[juggernaut].read[kits].get[<player.flag[juggernaut_data.preview_kit]>]>
    - define item <[kit_root].get[chestplate_type]>[lore=<&7>Armor:<&sp><&a><[kit_root.armor]><&nl><&7>Armor<&sp>Tougness:<&sp><&a><[kit_root.armor_toughness]><&nl><&7>Speed:<&sp><&a><[kit_root.speed]>;hides=ALL;unbreakable=true]
    - define list:->:<[item]>
    - repeat 37:
        - if <[value]> == 37:
            - define value 41
        - if <[kit_root.inventory.<[value]>].exists>:
            - define item_root <[kit_root.inventory.<[value]>]>
            - define item <[item_root].get[type].as_item>
            - define lore <list[]>
            - if <[item_root.attack_damage].exists>:
                - define lore:->:<&7>Attack<&sp>Damage:<&sp><&a><[item_root.attack_damage]>
            - if <[item_root.attack_speed].exists>:
                - define lore:->:<&7>Attack<&sp>Speed:<&sp><&a><[item_root.attack_speed]>
            - if <[item_root.projectile_damage].exists>:
                - define lore:->:<&7>Projectile<&sp>Damage:<&sp><&a><[item_root.projectile_damage]>
            - if <[item_root.ability].exists>:
                - define lore:->:<&7>Ability:<&sp><&a><[item_root.ability.display_name]>
                - define lore:->:<&e><&sp>Description<&sp><&7>-<&sp><[item_root.ability.description].split_lines_by_width[250].replace[<&nl>].with[<&nl><&sp><&7>]>
                - foreach <[item_root.ability.description_stats]>:
                    - if <[item_root.ability.<[value]>.player].exists> || <[item_root.ability.<[value]>.juggernaut].exists>:
                        - define lore:->:<&e><&sp><[key]><&sp><&7>-<&sp><&f><[item_root.ability.<[value]>.player].if_null[<[item_root.ability.<[value]>]>]><&7>/<&c><[item_root.ability.<[value]>.juggernaut].if_null[<[item_root.ability.<[value]>]>]>
                    - else:
                        - define lore:->:<&e><&sp><[key]><&sp><&7>-<&sp><&a><[item_root.ability.<[value]>]>
            - adjust def:item lore:<[lore]>
            - adjust def:item hides:all
            - adjust def:item unbreakable:true
            - define list:->:<[item]>
        - else:
            - define list:->:air
    - determine <[list]>
  slots:
    - [b] [g] [g] [g] [] [g] [g] [g] [g]
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [] [] [] [] [] [] [] []
    - [] [g] [g] [g] [g] [g] [g] [g] [g]
jug_kit_inv_click:
    type: world
    debug: false
    events:
        on player clicks item_flagged:kit in jug_*:
        - if <context.item.flag[kit]> != random:
            - if <context.click> == LEFT:
                - flag <player> juggernaut_data.kit:<context.item.flag[kit]>
                - flag <player> juggernaut_data.kit_selection:!
                - inventory set d:<player.inventory> o:<yaml[juggernaut].read[kits.<player.flag[juggernaut_data.kit]>.gui_item]>[display_name=<&7>Selected<&sp>Kit:<&sp><&color[#<yaml[juggernaut].read[kits.<player.flag[juggernaut_data.kit]>.primary_color]>]><&l><yaml[juggernaut].read[kits.<player.flag[juggernaut_data.kit]>.display_name]>] slot:5
                - if <player.has_flag[juggernaut_data.dead]>:
                    - if !<player.has_flag[juggernaut_data.dead_countdown]>:
                        - run jug_respawn_script player:<player>
                - inventory close o:<player.inventory>
            - else if <context.click> == RIGHT:
                - flag <player> juggernaut_data.preview_kit:<context.item.flag[kit]>
                - inventory open d:jug_kit_preview_gui
        - else:
            - flag <player> juggernaut_data.kit:!
            - flag <player> juggernaut_data.kit_selection:!
            - inventory set d:<player.inventory> o:FIREWORK_STAR[display_name=<&7>Selected<&sp>Kit:<&sp><&l>Random] slot:5
            - if <player.has_flag[juggernaut_data.dead]>:
                - if !<player.has_flag[juggernaut_data.dead_countdown]>:
                    - run jug_respawn_script player:<player>
            - inventory close o:<player.inventory>
        on player clicks item_flagged:menu in jug_*:
        - narrate <context.item.flag[page]>
        - if <context.item.has_flag[page]>:
            - flag <player> gui_page:+:<context.item.flag[page]>
        - inventory open d:<context.item.flag[menu]>
        after player flagged:juggernaut_data.kit_selection closes jug_kit_selection_gui:
        - wait 1t
        - if <player.open_inventory> == <player.inventory>:
            - inventory open d:JUG_KIT_SELECTION_GUI
jug_give_kit:
    type: task
    script:
    - if !<player.has_flag[juggernaut_data.kit]>:
        - flag <player> juggernaut_data.kit:<yaml[juggernaut].read[kits].keys.random>
    - define kit_root <yaml[juggernaut].read[kits].get[<player.flag[juggernaut_data.kit]>]>
    - inventory clear d:<player.inventory>
    - inventory set d:<player.inventory> o:leather_boots[color=#<[kit_root].get[secondary_color]>;attribute_modifiers=<map.with[GENERIC_armor].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[0].with[slot].as[FEET]>]>]>;hides=ALL;unbreakable=true] slot:37
    - inventory set d:<player.inventory> o:leather_leggings[color=#<[kit_root].get[primary_color]>;attribute_modifiers=<map.with[GENERIC_armor].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[0].with[slot].as[LEGS]>]>]>;hides=ALL;unbreakable=true] slot:38
    - inventory set d:<player.inventory> o:<[kit_root].get[chestplate_type]>[attribute_modifiers=<map.with[GENERIC_armor].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[<[kit_root.armor]>].with[slot].as[CHEST]>]>].with[GENERIC_ARMOR_TOUGHNESS].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[<[kit_root.armor_toughness]>].with[slot].as[CHEST]>]>].with[GENERIC_KNOCKBACK_RESISTANCE].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[0].with[slot].as[CHEST]>]>].with[GENERIC_MOVEMENT_SPEED].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[<[kit_root.speed].sub[0.1]>].with[slot].as[CHEST]>]>]>;hides=ALL;unbreakable=true] slot:39
    - foreach <[kit_root].get[inventory]>:
        - define item <[value].get[type].as_item>
        - adjust def:item attribute_modifiers:<map.with[GENERIC_ATTACK_DAMAGE].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[<[value.attack_damage].sub[1].if_null[0]>].with[slot].as[HAND]>]>].with[GENERIC_ATTACK_SPEED].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[<[value.attack_speed].sub[4].if_null[0]>].with[slot].as[HAND]>]>]>
        - adjust def:item flag:kit_item:<[key]>
        - if <[value.projectile_damage].exists>:
            - adjust def:item flag:projectile_damage:<[value.projectile_damage]>
        - adjust def:item hides:all
        - if !<[value.durability].exists>:
            - adjust def:item unbreakable:true
        - else:
            - adjust def:item durability:<[item].max_durability.sub[<[value.durability]>]>
        - inventory set d:<player.inventory> o:<[item]> slot:<[key]>
    - give compass[display_name=<&c>Juggernaut<&sp>Tracker]
jug_abilities:
    type: world
    events:
        on player flagged:juggernaut_data.in_game clicks block with:item_flagged:kit_item:
        - define ability <yaml[juggernaut].read[kits.<player.flag[juggernaut_data.kit]>.inventory.<context.item.flag[kit_item]>.ability]>
        - if <[ability.click_type]> == right:
            - if <context.click_type> != RIGHT_CLICK_AIR && <context.click_type> != RIGHT_CLICK_BLOCK:
                - stop
        - else if <[ability.click_type]> == left:
            - if <context.click_type> != LEFT_CLICK_AIR && <context.click_type> != LEFT_CLICK_BLOCK:
                - stop
        - else:
            - stop
        - if <player.has_flag[juggernaut_data.is_juggernaut]>:
            - define player_type juggernaut
        - else:
            - define player_type player
        - if <util.time_now.duration_since[<context.item.flag[last_used]>].in_seconds> >= <[ability.cooldown.<[player_type]>].if_null[<[ability.cooldown]>]> || !<context.item.flag[last_used].exists>:
            - inventory adjust slot:<player.held_item_slot> flag:last_used:<util.time_now>
            - run jug_ability_actionbar def:<context.item.flag[kit_item]>|<util.time_now>|<[ability]>|<[player_type]>|
            - choose <[ability.type]>:
                - case tank:
                    - cast damage_resistance duration:<[ability.duration.<[player_type]>].if_null[<[ability.duration]>]> amplifier:9
                    - define enchant_armor true
                - case sharpshooter:
                    - if !<context.item.has_flag[ability_charge]>:
                        - inventory adjust slot:<player.held_item_slot> enchantments:<map[].with[luck].as[1]>
                        - inventory adjust slot:<player.held_item_slot> flag:ability_charge:sharpshooter
                    - else:
                        - narrate "<&c>You already have this ability applied!"
                        - stop
                - case archer:
                    - spawn arrow <player.eye_location.forward> save:archer_arrow
                    - adjust <entry[archer_arrow].spawned_entity> velocity:<player.location.direction.vector.mul[<[ability.arrow_speed.<[player_type]>].if_null[<[ability.arrow_speed]>]>]>
                    - adjust <entry[archer_arrow].spawned_entity> shooter:<player>
                    - adjust <entry[archer_arrow].spawned_entity> damage:<[ability.arrow_damage.<[player_type]>].if_null[<[ability.arrow_damage]>]>
                    - adjust <entry[archer_arrow].spawned_entity> pickup_status:DISALLOWED
                - case healer:
                    - heal <[ability.heal_amount.<[player_type]>].if_null[<[ability.heal_amount]>]>
                    - playeffect effect:heart at:<player.location> quantity:50 offset:0.2,0.8,0.2
                - case assassin:
                    - repeat <[ability.blink_duration.<[player_type]>].if_null[<[ability.blink_duration]>].mul[20].round>:
                        - if !<player.has_flag[juggernaut_data.dead]>:
                            - adjust <player> velocity:<player.location.direction.vector.mul[<[ability.blink_velocity.<[player_type]>].if_null[<[ability.blink_velocity]>]>]>
                            - adjust <player> fake_experience:<element[1].sub[<[value].div[<[ability.blink_duration.<[player_type]>].if_null[<[ability.blink_duration]>].mul[20].round>]>]>|0
                            - wait 1t
                        - else:
                            - adjust <player> fake_experience
                            - stop
                    - adjust <player> velocity:<player.location.direction.vector.mul[0]>
                    - adjust <player> fake_experience
                - case ninja:
                    - cast invisibility duration:<[ability.duration.<[player_type]>].if_null[<[ability.duration]>]>
                    - playeffect at:<player.location.add[0,0.5,0]> effect:SMOKE_LARGE quantity:500
                    - run jug_ninja_ability def:<[ability.duration.<[player_type]>].if_null[<[ability.duration]>]>
            - if <[enchant_armor]>:
                - inventory adjust slot:39 enchantments:<map[].with[luck].as[1]>
                - wait <[ability.duration.<[player_type]>].if_null[<[ability.duration]>]>s
                - inventory adjust slot:39 remove_enchantments:<list[].include[luck]>
        - else:
            - narrate "<&c>Your ability is still on cooldown for <&l><[ability.cooldown.<[player_type]>].if_null[<[ability.cooldown]>].sub[<util.time_now.duration_since[<context.item.flag[last_used]>].in_seconds>].round_up>s<&c>!"
        on player flagged:juggernaut_data.in_game toggles item_flagged:kit_item:
        - if <context.state>:
            - if <player.item_in_hand.advanced_matches[shield]>:
                - define slot <player.held_item_slot>
                - define item <player.item_in_hand>
                - define ability <yaml[juggernaut].read[kits.<player.flag[juggernaut_data.kit]>.inventory.<player.item_in_hand.flag[kit_item]>.ability]>
            - else if <player.item_in_offhand.advanced_matches[shield]>:
                - define slot 41
                - define item <player.item_in_offhand>
                - define ability <yaml[juggernaut].read[kits.<player.flag[juggernaut_data.kit]>.inventory.<player.item_in_offhand.flag[kit_item]>.ability]>
            - else:
                - stop
            - if <[ability.click_type]> == shift_shield:
                - if !<player.is_sneaking>:
                    - stop
            - if <player.item_cooldown[shield].in_seconds> > 0:
                - stop
            - if <player.has_flag[juggernaut_data.is_juggernaut]>:
                - define player_type juggernaut
            - else:
                - define player_type player
            - if <util.time_now.duration_since[<[item].flag[last_used]>].in_seconds> >= <[ability.cooldown.<[player_type]>].if_null[<[ability.cooldown]>]> || !<[item].flag[last_used].exists>:
                - inventory adjust slot:<[slot]> flag:last_used:<util.time_now>
                - run jug_ability_actionbar def:<[item].flag[kit_item]>|<util.time_now>|<[ability]>|<[player_type]>|
                - choose <[ability.type]>:
                    - case knight:
                        - inventory adjust slot:<[slot]> flag:ability_active:true
                        - repeat <[ability.bash_duration.<[player_type]>].if_null[<[ability.bash_duration]>].mul[20].round>:
                            - if <player.inventory.slot[<[slot]>].has_flag[ability_active]> && !<player.has_flag[juggernaut_data.dead]>:
                                - adjust <player> velocity:<player.location.direction.vector.mul[<[ability.bash_velocity.<[player_type]>].if_null[<[ability.bash_velocity]>]>].with_y[-1]>
                                - adjust <player> fake_experience:<element[1].sub[<[value].div[<[ability.bash_duration.<[player_type]>].if_null[<[ability.bash_duration]>].mul[20].round>]>]>|0
                                - hurt <[ability.bash_damage.<[player_type]>].if_null[<[ability.bash_damage]>]> <player.eye_location.find_entities[player].within[2].exclude[<player>]> source:<player> cause:ENTITY_ATTACK
                                - wait 1t
                            - else:
                                - adjust <player> fake_experience
                                - inventory adjust slot:<[slot]> flag:ability_active:!
                                - stop
                        - adjust <player> velocity:<player.location.direction.vector.mul[0]>
                - inventory adjust slot:<[slot]> flag:ability_active:!
            - else:
                - narrate "<&c>Your ability is still on cooldown for <&l><[ability.cooldown.<[player_type]>].if_null[<[ability.cooldown]>].sub[<util.time_now.duration_since[<[item].flag[last_used]>].in_seconds>].round_up>s<&c>!"
        - else:
            - if <player.item_in_hand.advanced_matches[shield]>:
                - define slot <player.held_item_slot>
            - else if <player.item_in_offhand.advanced_matches[shield]>:
                - define slot 41
            - inventory adjust slot:<[slot]> flag:ability_active:!
        on player breaks held shield:
            - narrate <context.slot>
            - define item <context.item>
            - define slot <context.slot>
            - adjust def:item durability:<[item].max_durability.sub[<yaml[juggernaut].read[kits.<player.flag[juggernaut_data.kit]>.inventory.<[item].flag[kit_item]>.durability]>]>
            - wait 1t
            - inventory set d:<player.inventory> o:air slot:<[slot]>
            - animate <player> STOP_USE_ITEM
            - wait 1t
            - itemcooldown <[item].material> d:<yaml[juggernaut].read[kits.<player.flag[juggernaut_data.kit]>.inventory.<[item].flag[kit_item]>.durability_cooldown]>s
            - inventory set d:<player.inventory> o:<[item]> slot:<[slot]>
            # If this ever starts activating the ability while the player was sneaking when the cooldown ends (but without the player touching the shield), remove everything from here to the next comment
            - wait <yaml[juggernaut].read[kits.<player.flag[juggernaut_data.kit]>.inventory.<[item].flag[kit_item]>.durability_cooldown]>s
            - animate <player> START_USE_OFFHAND_ITEM
            - wait 1t
            - animate <player> STOP_USE_ITEM
            # Stop removing here.
jug_ninja_ability:
    type: task
    definitions: duration
    script:
        - cast remove glowing
        - flag <player> juggernaut_data.invis:true
        - narrate <server.flag[juggernaut_maps.<player.flag[juggernaut_data.map]>.game_data.players]>
        - fakeequip <player> for:<server.flag[juggernaut_maps.<player.flag[juggernaut_data.map]>.game_data.players].keys.exclude[<player>]> duration:<[duration]>s hand:air head:air chest:air legs:air boots:air
        - adjust <player> clear_body_arrows
        - repeat <[duration].mul[5]>:
            - playeffect effect:BLOCK_DUST at:<player.location> quantity:7 special_data:black_wool velocity:<location[0,-1,0]>
            - wait 0.2s
        - if <player.has_flag[juggernaut_data.in_game]>:
            - flag <player> juggernaut_data.invis:!
        - if <player.has_flag[juggernaut_data.is_juggernaut]>:
            - cast glowing duration:10000s <player> no_icon no_particles
        - if !<player.has_flag[juggernaut_data.dead]>:
            - playeffect at:<player.location.add[0,0.5,0]> effect:SMOKE quantity:500 data:0.1
jug_ability_actionbar:
    type: task
    debug: false
    definitions: item|use_time|ability|player_type|display_name
    script:
    - if !<[ability].exists>:
        - narrate "<&c>ERROR CODE 70: Invalid Ability."
        - stop
    - define wait_time <[ability.cooldown.<[player_type]>].if_null[<[ability.cooldown]>].div[15]>
    - if <[wait_time]> > 1.5:
        - define multiplier <[wait_time].div[1.5].round_up>
        - define wait_time:/:<[multiplier]>
    - else:
        - define multiplier 1
    - if <[ability.click_type]> == right:
        - define type_display <element[Right<&sp>Click]>
    - else if <[ability.click_type]> == left:
        - define type_display <element[Right<&sp>Click]>
    - else if <[ability.click_type]> == shift_shield:
        - define type_display <element[Shift<&sp>Shield]>
    - actionbar "<&e><[ability.display_name]> (<[type_display]>) <&7><&l><element[|].repeat[15]>"
    - repeat <[multiplier].mul[15].if_null[15]>:
        - if !<player.has_flag[juggernaut_data.dead]> && <player.has_flag[juggernaut_data.in_game]>:
            - waituntil <[wait_time].mul[<[value]>]> <= <util.time_now.duration_since[<[use_time]>].in_seconds>
            - define bars <[value].div[<[multiplier]>].round_down.if_null[<[value]>]>
            - actionbar "<&e><[ability.display_name]> (<[type_display]>) <&c><&l><element[|].repeat[<[bars]>]><&7><&l><element[|].repeat[<[bars].sub[15].abs>]>"
        - else:
            - stop
    - actionbar "<&e><[ability.display_name]> (<[type_display]>) <&a><&l>READY!"
    - narrate "<&e><[ability.display_name]> <&a>is ready!"
jug_load_config:
    type: world
    events:
        on server start:
        - yaml load:juggernaut.yml id:juggernaut
        on reload scripts:
        - yaml load:juggernaut.yml id:juggernaut
jug_viewers:
    type: procedure
    definitions: map
    script:
    - if <server.flag[juggernaut_maps.<[map]>.game_data.spectators].exists>:
        - determine <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.include[<server.flag[juggernaut_maps.<[map]>.game_data.spectators]>]>
    - else:
        - determine <server.flag[juggernaut_maps.<[map]>.game_data.players].keys>
jug_active_players:
    type: procedure
    definitions: map
    script:
    - determine <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.filter_tag[<[filter_value].has_flag[juggernaut_data.dead].not>].filter_tag[<[filter_value].has_flag[juggernaut_data.spectator].not>]>
jug_map_assignment:
## When assigning, do '/npc assign --set jug_map_assignment'
    type: assignment
    actions:
        on assignment:
        - narrate "NPC assigned to Juggernaut maps"
    interact scripts:
    - jug_map_interact
jug_map_interact:
    type: interact
    steps:
        1:
            click trigger:
                script:
                - flag <player> gui_page:1
                - inventory open d:jug_map_selection_gui
jug_tutorial:
    type: task
    definitions: stage
    script:
    - choose <[stage]>:
        - case intro:
            - clickable jug_tutorial def:points usages:1 save:next
            - clickable jug_tutorial def:none usages:1 save:prev
            - narrate "<&c><&l>-/-/-/- <&e>Introduction to Juggernaut <&c><&l>-\-\-\-<&nl><&7>Welcome to Juggernaut! Juggernaut is sort of like a reverse tag in Minecraft, with one player being it (the juggernaut), and everyone else trying to kill them to become the juggernaut. If you want more information, I would recommend clicking the arrows below to look at the next pages!<&nl><&c><&l>-/-/-/- <element[<&e>≪<&sp>Prev].on_click[<entry[prev].command>]> <&c><&l>-/-\- <element[<&e>Next<&sp>≫].on_click[<entry[next].command>]> <&c><&l>-\-\-\-"
        - case points:
            - clickable jug_tutorial def:starting usages:1 save:next
            - clickable jug_tutorial def:intro usages:1 save:prev
            - narrate "<&c><&l>-/-/-/- <&e>Score & Winning <&c><&l>-\-\-\-<&nl><&7>In order to win, you must reach a certain amount of points specified in the sidebar. There are two ways to get points: Either kill the juggernaut (<&a><yaml[juggernaut].read[kill_juggernaut_points].if_null[null]><&7>), or kill a player as the juggernaut (<&a><yaml[juggernaut].read[juggernaut_kill_points].if_null[null]><&7>).<&nl><&c><&l>-/-/-/- <element[<&e>≪<&sp>Prev].on_click[<entry[prev].command>]> <&c><&l>-/-\- <element[<&e>Next<&sp>≫].on_click[<entry[next].command>]> <&c><&l>-\-\-\-"
        - case starting:
            - clickable jug_tutorial def:kits usages:1 save:next
            - clickable jug_tutorial def:points usages:1 save:prev
            - narrate "<&c><&l>-/-/-/- <&e>Starting a Game <&c><&l>-\-\-\-<&nl><&7>Once you have clicked a map, you will get put into a waiting lobby. Here, you can pick your kit (your choice resets every time you join a lobby), and you can ready up. If every player is ready, the game countdown is automatically set to be lower and the game will start momentarily.<&nl><&c><&l>-/-/-/- <element[<&e>≪<&sp>Prev].on_click[<entry[prev].command>]> <&c><&l>-/-\- <element[<&e>Next<&sp>≫].on_click[<entry[next].command>]> <&c><&l>-\-\-\-"
        - case kits:
            - clickable jug_tutorial def:none usages:1 save:next
            - clickable jug_tutorial def:starting usages:1 save:prev
            - narrate "<&c><&l>-/-/-/- <&e>Kits & Abilities <&c><&l>-\-\-\-<&nl><&7>There are several kits you can choose from. Don't worry, you can switch kits every time you die! If you want to see what a kit does, just right click and it will show a preview of the kit. Kits also have abilities that can be activated by clicking on an item while playing, and have various powers. These abilities are even more powerful if you are the juggernaut!<&nl><&c><&l>-/-/-/- <element[<&e>≪<&sp>Prev].on_click[<entry[prev].command>]> <&c><&l>-/-\- <element[<&e>Next<&sp>≫].on_click[<entry[next].command>]> <&c><&l>-\-\-\-"
        - case none:
            - narrate "<&c>I'm sorry, that page doesn't exist."
jug_protections:
    type: world
    events:
        on player flagged:juggernaut_data.in_game breaks block:
        - determine passively cancelled
        on player flagged:juggernaut_data.in_game places block:
        - determine passively cancelled
        on player flagged:juggernaut_data.in_game drops item:
        - determine passively cancelled
        on player flagged:juggernaut_data.in_game swaps items:
        - determine passively cancelled
jug_jug_tracker:
    type: world
    debug: false
    events:
        on player flagged:juggernaut_data.is_juggernaut walks:
        - ratelimit <player> 1s
        - define map <player.flag[juggernaut_data.map]>
        - define juggernaut <player>
        - foreach <server.flag[juggernaut_maps.<[map]>.game_data.players].keys>:
            - run jug_jug_tracker_update def:<[juggernaut]> player:<[value]>
        on player flagged:juggernaut_data.in_game clicks block with:compass bukkit_priority:LOW:
        - determine passively cancelled
jug_jug_tracker_update:
    type: task
    debug: false
    definitions: juggernaut
    script:
    - compass <[juggernaut].location>
jug_jug_res_proc:
    type: procedure
    definitions: map|cause
    script:
    - define minPlayers <yaml[juggernaut].read[juggernaut_settings.resistances.min_players]>
    - define perPlayer <yaml[juggernaut].read[juggernaut_settings.resistances.base.per_player]>
    - define maxRes <yaml[juggernaut].read[juggernaut_settings.resistances.base.max_res]>
    - define players <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size>
    - if <[players]> < <[minPlayers]>:
        - determine 1
    - define baseResistance <element[1].sub[<[players].add[1].sub[<[minPlayers]>].mul[<[perPlayer]>].min[<[maxRes]>]>]>
    - if !<yaml[juggernaut].read[juggernaut_settings.resistances.<[cause]>].exists>:
        - determine <[baseResistance]>
    - define perPlayer <yaml[juggernaut].read[juggernaut_settings.resistances.<[cause]>.per_player]>
    - define maxRes <yaml[juggernaut].read[juggernaut_settings.resistances.<[cause]>.max_res]>
    - define bonusResistance <element[1].sub[<[players].add[1].sub[<[minPlayers]>].mul[<[perPlayer]>].min[<[maxRes]>]>]>
    - determine <[baseResistance].mul[<[bonusResistance]>]>