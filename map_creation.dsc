juggernaut_command:
    type: command
    name: juggernaut
    description: Juggernaut command.
    usage: /juggernaut
    debug: false
    permission: juggernaut.command
    tab complete:
    - define args <context.args>
    - define mods <list>
    - if <player.has_permission[juggernaut.bypass.hidden]>:
        - define maps <server.flag[juggernaut_maps].keys>
    - else:
        - define maps <server.flag[juggernaut_maps].keys.filter_tag[<server.flag[juggernaut_maps.<[filter_value]>.hidden].is_truthy.not>]>
    - foreach <[args]>:
        - if <[value].regex_matches[^-.*]>:
            - define args:<-:<[value]>
            - define mods:->:<[value]>
    - define perm juggernaut.help
    - inject jug_perms
    - choose <[args].get[1].if_null[null]>:
        - case map:
            - define perm juggernaut.map.help
            - inject jug_perms
            - choose <[args].get[2].if_null[null]>:
                - case remove:
                    - define perm juggernaut.map.remove
                    - inject jug_perms
                    - if <context.args.get[4].exists>:
                        - define maps:<list>
                        - define maps:->:-b
                    - if <context.raw_args.ends_with[<&sp>]> && <context.args.get[3].exists>:
                        - define maps:<list>
                        - define maps:->:-b
                    - determine <[maps]>
                - case end:
                    - define perm juggernaut.map.end
                    - inject jug_perms
                    - if <context.args.get[4].exists>:
                        - stop
                    - if <context.raw_args.ends_with[<&sp>]> && <context.args.get[3].exists>:
                        - stop
                    - determine <[maps]>
                - case close:
                    - define perm juggernaut.map.close
                    - inject jug_perms
                    - if <context.args.get[4].exists>:
                        - stop
                    - if <context.raw_args.ends_with[<&sp>]> && <context.args.get[3].exists>:
                        - stop
                    - determine <[maps]>
                - case open:
                    - define perm juggernaut.map.open
                    - inject jug_perms
                    - if <context.args.get[4].exists>:
                        - stop
                    - if <context.raw_args.ends_with[<&sp>]> && <context.args.get[3].exists>:
                        - stop
                    - determine <[maps]>
                - case hide:
                    - define perm juggernaut.map.hide
                    - inject jug_perms
                    - if <context.args.get[4].exists>:
                        - stop
                    - if <context.raw_args.ends_with[<&sp>]> && <context.args.get[3].exists>:
                        - stop
                    - determine <[maps]>
                - case show:
                    - define perm juggernaut.map.show
                    - inject jug_perms
                    - if <context.args.get[4].exists>:
                        - stop
                    - if <context.raw_args.ends_with[<&sp>]> && <context.args.get[3].exists>:
                        - stop
                    - determine <[maps]>
                - default:
                    - if <context.args.get[3].exists>:
                        - stop
                    - if <context.raw_args.ends_with[<&sp>]>:
                        - stop
                    - define list:->:help
                    - if <player.has_permission[juggernaut.map.create]>:
                        - define list:->:create
                    - if <player.has_permission[juggernaut.map.remove]>:
                        - define list:->:remove
                    - if <player.has_permission[juggernaut.map.end]>:
                        - define list:->:end
                    - if <player.has_permission[juggernaut.map.close]>:
                        - define list:->:close
                    - if <player.has_permission[juggernaut.map.open]>:
                        - define list:->:open
                    - if <player.has_permission[juggernaut.map.hide]>:
                        - define list:->:hide
                    - if <player.has_permission[juggernaut.map.show]>:
                        - define list:->:show
                    - if <player.has_permission[juggernaut.map.list]>:
                        - define list:->:list
                    - if <player.has_permission[juggernaut.map.edit]>:
                        - define list:->:edit
                    - determine <[list]>
        - case debug:
            - define perm juggernaut.debug.help
            - inject jug_perms
            - choose <[args].get[2].if_null[null]>:
                - case map:
                    - define perm juggernaut.debug.map
                    - inject jug_perms
                    - if <context.args.get[4].exists>:
                        - stop
                    - if <context.raw_args.ends_with[<&sp>]> && <context.args.get[3].exists>:
                        - stop
                    - determine <[maps]>
                - case player:
                    - define perm juggernaut.debug.player
                    - inject jug_perms
                    - if <context.args.get[4].exists>:
                        - stop
                    - if <context.raw_args.ends_with[<&sp>]> && <context.args.get[3].exists>:
                        - stop
                    - determine <server.online_players.parse_tag[<[parse_value].name>]>
                - default:
                    - if <context.args.get[3].exists>:
                        - stop
                    - if <context.raw_args.ends_with[<&sp>]>:
                        - stop
                    - define list:->:help
                    - if <player.has_permission[juggernaut.debug.player]>:
                        - define list:->:player
                    - if <player.has_permission[juggernaut.debug.map]>:
                        - define list:->:map
                    - determine <[list]>
        - default:
            - if <context.args.get[2].exists>:
                - stop
            - if <context.raw_args.ends_with[<&sp>]>:
                - stop
            - define list:->:help
            - if <player.has_permission[juggernaut.map.help]>:
                - define list:->:map
            - if <player.has_permission[juggernaut.debug.help]>:
                - define list:->:debug
            - if <player.has_permission[juggernaut.backup.help]>:
                - define list:->:backup
            - if <player.has_permission[juggernaut.open]>:
                - define list:->:open
            - if <player.has_permission[juggernaut.reload]>:
                - define list:->:reload
            - if <player.has_permission[juggernaut.leave]>:
                - define list:->:leave
            - if <player.has_permission[juggernaut.setspawn]>:
                - define list:->:setspawn
            - if <player.has_flag[jug_setup]>:
                - define list:->:setup
            - determine <[list]>
    script:
    - if <context.source_type> != PLAYER:
        - narrate "<&c>Command must be run by a player!"
        - stop
    - define args <context.args>
    - define mods <list>
    - foreach <[args]>:
        - if <[value].regex_matches[^-.*]>:
            - define args:<-:<[value]>
            - define mods:->:<[value]>
    - choose <[args].get[1].if_null[null]>:
        - case map:
            - if <[mods].contains[-b]>:
                - define skipBackup true
            - choose <[args].get[2].if_null[null]>:
                - case create:
                    - define perm juggernaut.map.create
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
                        - flag <player> jug_setup.type:1
                        - flag <player> jug_setup.current_map_setup_map:<map[]>
                        - flag <player> jug_setup.current_map_setup_name:<[args].get[3]>
                        - if <[skipBackup].exists>:
                            - flag <player> jug_setup.skip_backup:true
                        - if <[mods].contains[-c]>:
                            - flag <player> auto_close:true
                        - if <[mods].contains[-h]>:
                            - flag <player> auto_hide:true
                    - else:
                        - define prop_com "/juggernaut map create <&lt>name<&gt>"
                        - narrate <proc[jug_mis_arg].context[name|<[prop_com]>]>
                - case edit:
                    - define perm juggernaut.map.edit
                    - inject jug_perms
                    - if <[args].get[5].exists>:
                        - run JUG_EDIT_MAP_TASK def:<[args].get[3]>|<[args].get[4]>|<[args].get[5].to[last].space_separated.escaped>
                    - else:
                        - if <[args].get[4].exists>:
                            - define prop_com "/juggernaut map edit <&lt>map<&gt> <&lt>operation<&gt> <&lt>input<&gt>"
                            - narrate <proc[jug_mis_arg].context[input|<[prop_com]>]>
                        - else if <[args].get[3].exists>:
                            - define prop_com "/juggernaut map edit <&lt>map<&gt> <&lt>operation<&gt> <&lt>input<&gt>"
                            - narrate <proc[jug_mis_arg].context[operation|<[prop_com]>]>
                        - else:
                            - define prop_com "/juggernaut map edit <&lt>map<&gt> <&lt>operation<&gt> <&lt>input<&gt>"
                            - narrate <proc[jug_mis_arg].context[map|<[prop_com]>]>
                - case remove:
                    - define perm juggernaut.map.remove
                    - inject jug_perms
                    - if <player.has_flag[jug_setup]>:
                        - narrate "<&c>You already have another chat selection active. If this is unintentional type <proc[jug_setup_proc].context[cancel|normal]><&c>!"
                        - stop
                    - if <[args].get[3].exists>:
                        - if <server.flag[juggernaut_maps].keys.contains[<[args].get[3]>]>:
                            - flag <player> jug_setup.remove_map:<[args].get[3]>
                            - flag <player> jug_setup.type:remove
                            - if <[skipBackup].exists>:
                                - flag <player> jug_setup.skip_backup:true
                            - narrate "<&7>Please type in <proc[jug_setup_proc].context[confirm|normal]> <&7>to remove map, or <proc[jug_setup_proc].context[cancel|normal]> <&7>to cancel."
                        - else:
                            - narrate "<&c>Invalid map specified."
                    - else:
                        - define prop_com "/juggernaut map remove <&lt>name<&gt>"
                        - narrate <proc[jug_mis_arg].context[name|<[prop_com]>]>
                - case end:
                    - define perm juggernaut.map.end
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
                    - define perm juggernaut.map.close
                    - inject jug_perms
                    - if <[args].get[3].exists>:
                        - if <server.flag[juggernaut_maps.<[args].get[3]>.game_data.players].keys.size.if_null[0]> != 0:
                            - narrate "<&c>There are players currently on this map! In order to close this map, there must be no players on this map."
                            - stop
                        - if <server.flag[juggernaut_maps].keys.contains[<[args].get[3]>]>:
                            - flag server juggernaut_maps.<[args].get[3]>.closed:true
                            - narrate "<&a><[args].get[3]> <&7>closed."
                        - else:
                            - narrate "<&c>Invalid map specified."
                    - else:
                        - define prop_com "/juggernaut map close <&lt>name<&gt>"
                        - narrate <proc[jug_mis_arg].context[name|<[prop_com]>]>
                - case open:
                    - define perm juggernaut.map.open
                    - inject jug_perms
                    - if <[args].get[3].exists>:
                        - if <server.flag[juggernaut_maps].keys.contains[<[args].get[3]>]>:
                            - flag server juggernaut_maps.<[args].get[3]>.closed:!
                            - narrate "<&a><[args].get[3]> <&7>opened."
                        - else:
                            - narrate "<&c>Invalid map specified."
                    - else:
                        - define prop_com "/juggernaut map open <&lt>name<&gt>"
                        - narrate <proc[jug_mis_arg].context[name|<[prop_com]>]>
                - case hide:
                    - define perm juggernaut.map.hide
                    - inject jug_perms
                    - if <[args].get[3].exists>:
                        - if <server.flag[juggernaut_maps.<[args].get[3]>.game_data.players].keys.size.if_null[0]> != 0:
                            - narrate "<&c>There are players currently on this map! In order to hide this map, there must be no players on this map."
                            - stop
                        - if <server.flag[juggernaut_maps].keys.contains[<[args].get[3]>]>:
                            - flag server juggernaut_maps.<[args].get[3]>.hidden:true
                            - narrate "<&a><[args].get[3]> <&7>hidden."
                        - else:
                            - narrate "<&c>Invalid map specified."
                    - else:
                        - define prop_com "/juggernaut map hide <&lt>name<&gt>"
                        - narrate <proc[jug_mis_arg].context[name|<[prop_com]>]>
                - case show:
                    - define perm juggernaut.map.show
                    - inject jug_perms
                    - if <[args].get[3].exists>:
                        - if <server.flag[juggernaut_maps].keys.contains[<[args].get[3]>]>:
                            - flag server juggernaut_maps.<[args].get[3]>.hidden:!
                            - narrate "<&a><[args].get[3]> <&7>shown."
                        - else:
                            - narrate "<&c>Invalid map specified."
                    - else:
                        - define prop_com "/juggernaut map show <&lt>name<&gt>"
                        - narrate <proc[jug_mis_arg].context[name|<[prop_com]>]>
                - case list:
                    - define perm juggernaut.map.list
                    - inject jug_perms
                    - narrate <server.flag[juggernaut_maps].keys.separated_by[,<&sp>]>
                - case help:
                    - define perm juggernaut.map.help
                    - inject jug_perms
                    - narrate <proc[jug_help_proc].context[map]>
                - default:
                    - define perm juggernaut.map.help
                    - inject jug_perms
                    - define prop_com "/juggernaut map help"
                    - narrate <proc[jug_help_arg].context[<[prop_com]>]>
        - case open:
            - define perm juggernaut.open
            - inject jug_perms
            - flag <player> gui_page:1
            - inventory open d:jug_map_selection_gui
            - while <player.open_inventory.script.name.if_null[null]> == jug_map_selection_gui:
                - inventory open d:jug_map_selection_gui
                - wait 1s
        - case host:
            - define perm juggernaut.host
            - inject jug_perms
            - define map <[args].get[2]>
            - if !<server.flag[juggernaut_maps.<[map]>].exists>:
                - narrate "<&c>Invalid map!"
                - stop
            - if <[mods].contains[-s]>:
                - if <server.flag[juggernaut_maps.<[map]>.host_data.host]> != <player>:
                    - narrate "<&c>You are not hosting that map!"
                    - stop
                - run jug_stop_hosting def:<[map]>
                - stop
            - if <proc[jug_viewers].context[<[map]>].size.if_null[0]> > 0:
                - narrate "<&c>In order to host, there must be no players currently in the map."
                - stop
            - if <player.has_flag[juggernaut_data.in_game]>:
                - narrate "<&c>You cannot host if you are already in a game!"
                - stop
            - if <server.flag[juggernaut_maps.<[map]>.closed].exists> && !<player.has_permission[juggernaut.bypass.closed]>:
                - narrate "<&c>Sorry, that map is closed!"
                - stop
            - flag server juggernaut_maps.<[map]>.host_data.host:<player>
            - flag server juggernaut_maps.<[map]>.host_data.host_phase:closed
            - flag server juggernaut_maps.<[map]>.game_data.spectators:->:<player>
            - flag <player> juggernaut_data:<map[].with[map].as[<[map]>].with[ready_spam].as[0].with[leave_spam].as[0].with[in_game].as[true].with[is_host].as[true].with[spectator].as[true]>
            - teleport <player> to:<server.flag[juggernaut_maps.<[map]>.waiting_spawn]>
            - flag <player> juggernaut_data.saved_inventory:<player.inventory>
            - inventory clear d:<player.inventory>
            - heal
            - feed <player> amount:20
            - adjust <player> invulnerable:true
            - inventory set d:<player.inventory> o:jug_waiting_leave slot:9
            - inventory set d:<player.inventory> o:jug_waiting_unspectate_item slot:8
            - inventory set d:<player.inventory> o:jug_host_settings_item slot:1
            - inventory set d:<player.inventory> o:jug_custom_settings_item slot:7
            - run jug_ready_xp def:<[map]>
        - case reload:
            - define perm juggernaut.reload
            - inject jug_perms
            - yaml load:scripts/Juggernaut/juggernaut.yaml id:juggernaut
            - narrate "<&a>Juggernaut config reloaded!"
        - case leave:
            - define perm juggernaut.leave
            - inject jug_perms
            - if <player.has_flag[juggernaut_data.in_game]>:
                - run jug_remove_player def:<player.flag[juggernaut_data].get[map]>
            - else:
                - narrate "<&c>You aren't in a game!"
        - case setspawn:
            - define perm juggernaut.setspawn
            - inject jug_perms
            - if <player.has_flag[jug_setup]>:
                    - narrate "<&c>You already have another chat selection active. If this is unintentional type <proc[jug_setup_proc].context[cancel|normal]><&c>!"
                    - stop
            - flag <player> jug_setup.type:spawn
            - narrate "<&7>Please stand where the Juggernaut lobby's spawn should be and type in one of the following: <&nl><proc[jug_setup_proc].context[save|normal]><&7>: Save an auto-corrected location <&nl><proc[jug_setup_proc].context[exact|normal]><&7>: Save your exact location <&nl><proc[jug_setup_proc].context[cancel|normal]><&7>: Cancel setting the spawn." targets:<player>
        - case help:
            - define perm juggernaut.help
            - inject jug_perms
            - narrate <proc[jug_help_proc].context[general]>
        - case setup:
            - define perm juggernaut.setup
            - inject jug_perms
            - if !<context.args.get[2].exists>:
                - narrate "<&c>No input found!"
                - stop
            # Reasoning for this: If I allow certain characters, it would start making lists and/ore maps and/or other problematic things, so I check to make sure it's only using non-problematic characters
            - if !<context.args.get[2].to[last].space_separated.matches_character_set[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_&,*<&sp>]>:
                - narrate "<&c>Invalid characters found!"
                - stop
            - run jug_setup_task def:<context.args.get[2].to[last].space_separated.escaped>
        - case debug:
            - choose <[args].get[2].if_null[null]>:
                - case map:
                    - define perm juggernaut.debug.map
                    - inject jug_perms
                    - if !<server.flag[juggernaut_maps.<[args].get[3]>].exists> && <[args].get[3].exists>:
                        - narrate "<&c>That map doesn't exist!"
                        - stop
                    - else if <[args].get[3].exists>:
                        - narrate <server.flag[juggernaut_maps.<[args].get[3]>]>
                    - else:
                        - narrate <server.flag[juggernaut_maps]>
                - case player:
                    - define perm juggernaut.debug.player
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
                    - define perm juggernaut.debug.help
                    - inject jug_perms
                    - narrate <proc[jug_help_proc].context[debug]>
                - default:
                    - define perm juggernaut.debug.help
                    - inject jug_perms
                    - define prop_com "/juggernaut debug help"
                    - narrate <proc[jug_help_arg].context[<[prop_com]>]>
        - case backup:
            - choose <[args].get[2].if_null[null]>:
                - case load:
                    - define perm juggernaut.backup.load
                    - inject jug_perms
                    - if <player.has_flag[jug_setup]>:
                        - narrate "<&c>You already have another chat selection active. If this is unintentional type <proc[jug_setup_proc].context[cancel|normal]><&c>!"
                        - stop
                    - if <[args].get[3].exists>:
                        - if <server.flag[juggernaut_backup_maps].keys.contains[<[args].get[3]>]>:
                            - flag <player> jug_setup.load_map:<[args].get[3]>
                            - flag <player> jug_setup.type:backup_load
                            - if <[mods].contains[-h]>:
                                - flag <player> auto_hide:true
                            - if <[mods].contains[-c]>:
                                - flag <player> auto_close:true
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
                    - define perm juggernaut.backup.remove
                    - inject jug_perms
                    - if <player.has_flag[jug_setup]>:
                        - narrate "<&c>You already have another chat selection active. If this is unintentional type <proc[jug_setup_proc].context[cancel|normal]><&c>!"
                        - stop
                    - if <[args].get[3].exists>:
                        - if <server.flag[juggernaut_backup_maps].keys.contains[<[args].get[3]>]>:
                            - flag <player> jug_setup.remove_map:<[args].get[3]>
                            - flag <player> jug_setup.type:backup_remove
                            - narrate "<&7>Please type in <proc[jug_setup_proc].context[confirm|normal]> <&7>to remove backup map, or <proc[jug_setup_proc].context[cancel|normal]> <&7>to cancel."
                        - else:
                            - narrate "<&c>Invalid map specified."
                    - else:
                        - define prop_com "/juggernaut backup remove <&lt>name<&gt>"
                        - narrate <proc[jug_mis_arg].context[name|<[prop_com]>]>
                - case save:
                    - define perm juggernaut.backup.save
                    - inject jug_perms
                    - if <player.has_flag[jug_setup]>:
                        - narrate "<&c>You already have another chat selection active. If this is unintentional type <proc[jug_setup_proc].context[cancel|normal]><&c>!"
                        - stop
                    - if <[args].get[3].exists>:
                        - if <server.flag[juggernaut_maps].keys.contains[<[args].get[3]>]>:
                            - flag <player> jug_setup.save_map:<[args].get[3]>
                            - flag <player> jug_setup.type:backup_save
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
                    - define perm juggernaut.backup.list
                    - inject jug_perms
                    - narrate <server.flag[juggernaut_backup_maps].keys.separated_by[,<&sp>]>
                - case help:
                    - define perm juggernaut.backup.help
                    - inject jug_perms
                    - narrate <proc[jug_help_proc].context[backup]>
                - default:
                    - define perm juggernaut.backup.help
                    - inject jug_perms
                    - define prop_com "/juggernaut backup help"
                    - narrate <proc[jug_help_arg].context[<[prop_com]>]>
        - default:
            - define perm juggernaut.help
            - inject jug_perms
            - define prop_com "/juggernaut help"
            - narrate <proc[jug_help_arg].context[<[prop_com]>]>
jug_perms:
    type: task
    definitions: perm
    debug: false
    script:
    - if !<player.has_permission[<[perm]>]>:
        - narrate "<&c>No permission!"
        - stop
jug_help_proc:
    type: procedure
    definitions: type
    debug: false
    script:
    - define list <list[]>
    - if <[type]> == general:
        - define list:->:<&e><&l>Help<&sp>for<&sp>Juggernaut<&co>
        - if <player.has_permission[juggernaut.map.help]>:
            - define msg "<&a>/juggernaut map <&c><&l><element[^].on_click[/juggernaut<&sp>map<&sp>help].on_hover[<&7>Click<&sp>here<&sp>for<&sp>map<&sp>help.]> <&7>- Commands involving the management of maps"
            - define list:->:<[msg]>
        - if <player.has_permission[juggernaut.debug.help]>:
            - define msg "<&a>/juggernaut debug <&c><&l><element[^].on_click[/juggernaut<&sp>debug<&sp>help].on_hover[<&7>Click<&sp>here<&sp>for<&sp>debug<&sp>help.]> <&7>- Commands to assist with debugging"
            - define list:->:<[msg]>
        - if <player.has_permission[juggernaut.backup.help]>:
            - define msg "<&a>/juggernaut backup <&c><&l><element[^].on_click[/juggernaut<&sp>backup<&sp>help].on_hover[<&7>Click<&sp>here<&sp>for<&sp>backup<&sp>help.]> <&7>- Commands to interact with map backups"
            - define list:->:<[msg]>
        - if <player.has_permission[juggernaut.open]>:
            - define msg "<&a>/juggernaut open <&7>- Opens the map selection menu"
            - define list:->:<[msg]>
        - if <player.has_permission[juggernaut.reload]>:
            - define msg "<&a>/juggernaut reload <&7>- Reloads the Juggernaut config files"
            - define list:->:<[msg]>
        - if <player.has_permission[juggernaut.leave]>:
            - define msg "<&a>/juggernaut leave <&7>- Leaves the game you are currently in"
            - define list:->:<[msg]>
        - if <player.has_permission[juggernaut.setspawn]>:
            - define msg "<&a>/juggernaut setspawn <&7>- Sets the location players spawn after leaving a game"
            - define list:->:<[msg]>
    - else if <[type]> == map:
        - define list:->:<&e><&l>Help<&sp>for<&sp>Juggernaut<&sp>maps<&co>
        - if <player.has_permission[juggernaut.map.create]>:
            - define msg "<&a>/juggernaut map create <&lt>name<&gt> <element[<&e>[-b]].on_hover[<&7>Prevent<&sp>saving<&sp>changes<&sp>to<&sp>backup]> <element[<&e>[-c]].on_hover[<&7>Automatically<&sp>closes<&sp>map]> <element[<&e>[-h]].on_hover[<&7>Automatically<&sp>hides<&sp>map]> <&7>- Starts setup process for a new map"
            - define list:->:<[msg]>
        - if <player.has_permission[juggernaut.map.remove]>:
            - define msg "<&a>/juggernaut map remove <&lt>name<&gt> <element[<&e>[-b]].on_hover[<&7>Prevent<&sp>saving<&sp>changes<&sp>to<&sp>backup]> <&7>- Removes a map"
            - define list:->:<[msg]>
        - if <player.has_permission[juggernaut.map.end]>:
            - define msg "<&a>/juggernaut map end <&lt>name<&gt> <&7>- Ends the current game running on this map"
            - define list:->:<[msg]>
        - if <player.has_permission[juggernaut.map.close]>:
            - define msg "<&a>/juggernaut map close <&lt>name<&gt> <&7>- Closes this map, meaning nobody can enter"
            - define list:->:<[msg]>
        - if <player.has_permission[juggernaut.map.open]>:
            - define msg "<&a>/juggernaut map open <&lt>name<&gt> <&7>- Opens this map, allowing players to enter"
            - define list:->:<[msg]>
        - if <player.has_permission[juggernaut.map.hide]>:
            - define msg "<&a>/juggernaut map hide <&lt>name<&gt> <&7>- Hides this map, meaning nobody can see it"
            - define list:->:<[msg]>
        - if <player.has_permission[juggernaut.map.show]>:
            - define msg "<&a>/juggernaut map show <&lt>name<&gt> <&7>- Shows this map, allowing players to see it"
            - define list:->:<[msg]>
        - if <player.has_permission[juggernaut.map.list]>:
            - define msg "<&a>/juggernaut map list <&7>- Lists the names of all current maps."
            - define list:->:<[msg]>
    - else if <[type]> == debug:
        - define list:->:<&e><&l>Help<&sp>for<&sp>debug<&sp>commands<&co>
        - if <player.has_permission[juggernaut.debug.map]>:
            - define msg "<&a>/juggernaut debug map [name] <&7>- Shows juggernaut data for a map. If no map is specified, shows juggernaut data for all maps."
            - define list:->:<[msg]>
        - if <player.has_permission[juggernaut.debug.player]>:
            - define msg "<&a>/juggernaut debug player <&lt>name<&gt> <&7>- Shows juggernaut data for a player"
            - define list:->:<[msg]>
    - else if <[type]> == backup:
        - define list:->:<&e><&l>Help<&sp>for<&sp>backup<&sp>commands<&co>
        - if <player.has_permission[juggernaut.backup.save]>:
            - define msg "<&a>/juggernaut backup save <&lt>name<&gt> <&7>- Saves the current form of the map to a backup. This replaces any current backup of this map."
            - define list:->:<[msg]>
        - if <player.has_permission[juggernaut.backup.load]>:
            - define msg "<&a>/juggernaut backup load <&lt>name<&gt> <element[<&e>[-h]].on_hover[<&7>Automatically<&sp>hides<&sp>map]> <&7>- Loads the backup of a map to be the current map. This replaces any current version of this map."
            - define list:->:<[msg]>
        - if <player.has_permission[juggernaut.backup.remove]>:
            - define msg "<&a>/juggernaut backup remove <&lt>name<&gt> <&7>- Removes the backup of a map."
            - define list:->:<[msg]>
        - if <player.has_permission[juggernaut.backup.list]>:
            - define msg "<&a>/juggernaut backup list <&7>- Lists the names of all current backup maps."
            - define list:->:<[msg]>
    - determine <[list].separated_by[<&nl>]>
jug_mis_arg:
    type: procedure
    definitions: arg|command
    debug: false
    script:
    - determine "<&c>Missing argument for <&e><&lt><&6><[arg]><&e><&gt><&c>. <&nl><&c>Usage: <&6><[command].replace_text[<&gt>].with[<&e><&gt><&6>].replace_text[<&lt>].with[<&e><&lt><&6>]>"
jug_help_arg:
    type: procedure
    definitions: command
    debug: false
    script:
    - determine "<&c>Missing or invalid arguments. <&nl><&c>Help: <&6><[command].replace_text[<&gt>].with[<&e><&gt><&6>].replace_text[<&lt>].with[<&e><&lt><&6>]>"
jug_edit_map_task:
    type: task
    definitions: map|type|input
    debug: false
    script:
    - if !<server.flag[juggernaut_maps.<[map]>].exists>:
        - narrate "<&c>Invalid map!"
        - stop
    - choose <[type]>:
        - case display_name:
            - flag server juggernaut_maps.<[map]>.display_name:<[input]>
        - case waiting_spawn:
            - if <[input]> == save:
                - define location <player.location.round_down.add[0.5,0.5,0.5].with_yaw[<player.location.yaw.round_to_precision[45]>].with_pitch[0]>
            - else if <[input]> == exact:
                - define location <player.location>
            - else:
                - narrate "<&c>Invalid input! Valid Inputs: <&a>save <&c>to save rounded location, <&a>exact <&c>to save exact location."
                - stop
            - flag server juggernaut_maps.<[map]>.waiting_spawn:<[location]>
        - case spawn:
            - if <[input]> == save:
                - define location <player.location.round_down.add[0.5,0.5,0.5].with_yaw[<player.location.yaw.round_to_precision[45]>].with_pitch[0]>
            - else if <[input]> == exact:
                - define location <player.location>
            - else:
                - narrate "<&c>Invalid input! Valid Inputs: <&a>save <&c>to save rounded location, <&a>exact <&c>to save exact location."
                - stop
            - flag server juggernaut_maps.<[map]>.spawn:<[location]>
        - case juggernaut_spawn:
            - if <[input]> == save:
                - define location <player.location.round_down.add[0.5,0.5,0.5].with_yaw[<player.location.yaw.round_to_precision[45]>].with_pitch[0]>
            - else if <[input]> == exact:
                - define location <player.location>
            - else:
                - narrate "<&c>Invalid input! Valid Inputs: <&a>save <&c>to save rounded location, <&a>exact <&c>to save exact location."
                - stop
            - flag server juggernaut_maps.<[map]>.jug_spawn:<[location]>
        - case region:
            - if <[input]> == save:
                - if <player.we_selection.exists>:
                    - define region <player.we_selection>
                    - flag server juggernaut_maps.<[map]>.region:<[region]>
                    - note <[region]> as:jug_<[map]>
                - else:
                    - narrate "<&c>Make a WorldEdit region selection first."
                    - stop
            - else:
                - narrate "<&c>Invalid input! Valid Inputs: <&a>save <&c>to save current WorldEdit selection."
        - default:
            - narrate "<&c>Invalid operation! Valid Operations: <&6>display_name, waiting_spawn, spawn, juggernaut_spawn, region<&c>."
jug_setup_task:
    type: task
    definitions: message
    debug: false
    script:
    - if <player.has_flag[jug_setup]> && <[message]> == cancel:
        - if <player.has_flag[juggernaut_data.is_host]> && ( <player.flag[jug_setup.type]> == host_save || <player.flag[jug_setup.type]> == host_save_remove ):
            - inventory open d:jug_hosting_main_inv
        - flag <player> jug_setup:!
        - narrate <&a>Cancelled!
        - stop
    - if <player.flag[jug_setup.type]> == 1:
        - flag <player> jug_setup.current_map_setup_map:<player.flag[jug_setup.current_map_setup_map].with[display_name].as[<[message]>]>
        - flag <player> jug_setup.type:2
        - narrate "<&7>Please select the item to represent the map in your inventory, or type <proc[jug_setup_proc].context[cancel|normal]> <&7>to cancel setup." targets:<player>
    - else if <player.flag[jug_setup.type]> == 3:
        - if <[message]> == save:
            - define location <player.location.round_down.add[0.5,0.5,0.5].with_yaw[<player.location.yaw.round_to_precision[45]>].with_pitch[0]>
        - else if <[message]> == exact:
            - define location <player.location>
        - else:
            - narrate "<&c>Invalid choice!"
            - stop
        - flag <player> jug_setup.current_map_setup_map:<player.flag[jug_setup.current_map_setup_map].with[waiting_spawn].as[<[location]>]>
        - flag <player> jug_setup.type:4
        - narrate "<&7>Please stand where the main spawn should be and type in one of the following: <&nl><proc[jug_setup_proc].context[save|normal]><&7>: Save an auto-corrected location <&nl><proc[jug_setup_proc].context[exact|normal]><&7>: Save your exact location <&nl><proc[jug_setup_proc].context[cancel|normal]><&7>: Cancel the map creation." targets:<player>
    - else if <player.flag[jug_setup.type]> == 4:
        - if <[message]> == save:
            - define location <player.location.round_down.add[0.5,0.5,0.5].with_yaw[<player.location.yaw.round_to_precision[45]>].with_pitch[0]>
        - else if <[message]> == exact:
            - define location <player.location>
        - else:
            - narrate "<&c>Invalid choice!"
            - stop
        - flag <player> jug_setup.current_map_setup_map:<player.flag[jug_setup.current_map_setup_map].with[spawn].as[<[location]>]>
        - flag <player> jug_setup.type:5
        - narrate "<&7>Please stand where the juggernaut spawn should be and type in one of the following: <&nl><proc[jug_setup_proc].context[save|normal]><&7>: Save an auto-corrected location <&nl><proc[jug_setup_proc].context[exact|normal]><&7>: Save your exact location <&nl><proc[jug_setup_proc].context[cancel|normal]><&7>: Cancel the map creation." targets:<player>
    - else if <player.flag[jug_setup.type]> == 5:
        - if <[message]> == save:
            - define location <player.location.round_down.add[0.5,0.5,0.5].with_yaw[<player.location.yaw.round_to_precision[45]>].with_pitch[0]>
        - else if <[message]> == exact:
            - define location <player.location>
        - else:
            - narrate "<&c>Invalid choice!"
            - stop
        - flag <player> jug_setup.current_map_setup_map:<player.flag[jug_setup.current_map_setup_map].with[jug_spawn].as[<[location]>]>
        - flag <player> jug_setup.type:6
        - narrate "<&7>Please create a worldedit region around the map and type in one of the following: <&nl><proc[jug_setup_proc].context[save|normal]><&7>: Save the WorldEdit region <&nl><proc[jug_setup_proc].context[cancel|normal]><&7>: Cancel the map creation." targets:<player>
# The below must be the final step as it does a permanent thing.
    - else if <player.flag[jug_setup.type]> == 6:
        - if <[message]> == save:
            - if <player.we_selection.exists>:
                - define region <player.we_selection>
                - flag <player> jug_setup.current_map_setup_map:<player.flag[jug_setup.current_map_setup_map].with[region].as[<[region]>]>
                - note <[region]> as:jug_<player.flag[jug_setup.current_map_setup_name]>
            - else:
                - narrate "<&c>Make a WorldEdit region selection first."
                - stop
        - if <player.has_flag[auto_close]>:
            - flag <player> jug_setup.current_map_setup_map.closed:true
            - flag <player> auto_close:!
        - if <player.has_flag[auto_hide]>:
            - flag <player> jug_setup.current_map_setup_map.hidden:true
            - flag <player> auto_hide:!
        - flag <player> jug_setup.current_map_setup_map:<player.flag[jug_setup.current_map_setup_map].with[game_data].as[<map[].with[players].as[].with[spectators].as[<list[]>].with[juggernaut].as[].with[phase].as[0].with[dead].as[].with[countdown].as[0].with[saved_countdown].as[0].with[ready_players].as[<list[]>]>]>
        - if !<server.has_flag[juggernaut_maps]>:
            - flag server juggernaut_maps:<map[]>
        - flag server juggernaut_maps.<player.flag[jug_setup.current_map_setup_name]>:<player.flag[jug_setup.current_map_setup_map]>
        - if !<player.has_flag[jug_setup.skip_backup]>:
            - flag server juggernaut_backup_maps.<player.flag[jug_setup.current_map_setup_name]>:<player.flag[jug_setup.current_map_setup_map].exclude[hidden].exclude[closed]>
        - else:
            - flag <player> jug_setup.skip_backup:!
        - flag <player> jug_setup:!
    - else if <player.flag[jug_setup.type]> == spawn:
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
    - else if <player.flag[jug_setup.type]> == remove:
        - if <[message]> == confirm:
            - run jug_stop_game def:<player.flag[jug_setup.remove_map]>
            - note remove as:jug_<player.flag[jug_setup.remove_map]>
            - flag server juggernaut_maps.<player.flag[jug_setup.remove_map]>.game_data.countdown:!
            - flag server juggernaut_maps.<player.flag[jug_setup.remove_map]>.game_data.saved_countdown:!
            - flag server juggernaut_maps.<player.flag[jug_setup.remove_map]>:!
            - if !<player.has_flag[jug_setup.skip_backup]>:
                - flag server juggernaut_backup_maps.<player.flag[jug_setup.remove_map]>:!
            - else:
                - flag <player> jug_setup.skip_backup:!
            - narrate "<&a><player.flag[jug_setup.remove_map]> <&7>map successfully removed."
        - else:
            - narrate "<&c>Invalid choice!"
            - stop
        - flag <player> jug_setup:!
    - else if <player.flag[jug_setup.type]> == backup_remove:
        - if <[message]> == confirm:
            - flag server juggernaut_backup_maps.<player.flag[jug_setup.remove_map]>:!
            - narrate "<&a><player.flag[jug_setup.remove_map]> <&7>backup map successfully removed."
        - else:
            - narrate "<&c>Invalid choice!"
            - stop
        - flag <player> jug_setup:!
    - else if <player.flag[jug_setup.type]> == backup_load:
        - if <proc[jug_viewers].context[<player.flag[jug_setup.load_map]>].size.if_null[0]> != 0:
            - narrate "<&c>There must be no players in the active map in order to load/save maps to/from a backup!"
            - stop
        - if <[message]> == confirm:
            - note <server.flag[juggernaut_backup_maps.<player.flag[jug_setup.load_map]>.region]> as:jug_<player.flag[jug_setup.load_map]>
            - flag server juggernaut_maps.<player.flag[jug_setup.load_map]>:<server.flag[juggernaut_backup_maps.<player.flag[jug_setup.load_map]>]>
            - if <player.has_flag[auto_hide]>:
                - flag server juggernaut_maps.<player.flag[jug_setup.load_map]>.hidden:true
                - flag <player> auto_hide:!
            - if <player.has_flag[auto_close]>:
                - flag server juggernaut_maps.<player.flag[jug_setup.load_map]>.closed:true
                - flag <player> auto_close:!
            - narrate "<&a><player.flag[jug_setup.load_map]> <&7>map successfully loaded."
        - else:
            - narrate "<&c>Invalid choice!"
            - stop
        - flag <player> jug_setup:!
    - else if <player.flag[jug_setup.type]> == backup_save:
        - if <proc[jug_viewers].context[<player.flag[jug_setup.save_map]>].size.if_null[0]> != 0:
            - narrate "<&c>There must be no players in the active map in order to load/save maps to/from a backup!"
            - stop
        - if <[message]> == confirm:
            - flag server juggernaut_backup_maps.<player.flag[jug_setup.save_map]>:<server.flag[juggernaut_maps.<player.flag[jug_setup.save_map]>].exclude[hidden].exclude[closed]>
            - narrate "<&a><player.flag[jug_setup.save_map]> <&7>map successfully saved to a backup."
        - else:
            - narrate "<&c>Invalid choice!"
            - stop
        - flag <player> jug_setup:!
        - flag <player> jug_setup.save_map:!
    - else if <player.flag[jug_setup.type]> == host_save:
        - flag player juggernaut_custom_settings.save_name:<[message]>
        - flag player juggernaut_settings_saves.<player.flag[jug_setup.save_slot]>:<player.flag[juggernaut_custom_settings]>
        - narrate "<&7>Save <&a><[message].unescaped> <&7>saved to slot <&a><player.flag[jug_setup.save_slot]><&7>!" targets:<player>
        - if <player.has_flag[juggernaut_data.is_host]>:
            - inventory open d:jug_hosting_main_inv
        - flag <player> jug_setup:!
    - else if <player.flag[jug_setup.type]> == host_save_remove:
        - if <[message]> == confirm:
            - define save_slot:<player.flag[jug_setup.save_slot]>
            - if <player.flag[juggernaut_settings_saves.<[save_slot]>.save_name].exists>:
                - narrate "<&7>Save <&a><player.flag[juggernaut_settings_saves.<[save_slot]>.save_name].unescaped> <&7>in slot <&a><player.flag[jug_setup.save_slot]> <&7>removed!" targets:<player>
            - else:
                - narrate "<&7>Save slot <&a><player.flag[jug_setup.save_slot]> <&7>removed!" targets:<player>
            - flag player juggernaut_settings_saves.<[save_slot]>:!
            - if <player.has_flag[juggernaut_data.is_host]>:
                - inventory open d:jug_hosting_main_inv
            - flag <player> jug_setup:!
        - else:
            - narrate "<&c>Invalid choice!"
            - stop
jug_setup_event:
    type: world
    debug: false
    events:
        on player flagged:jug_setup clicks in player*:
        - if <player.flag[jug_setup.type]> == 2:
            - determine passively cancelled
            - if <context.item> != <item[air]>:
                - flag <player> jug_setup.current_map_setup_map:<player.flag[jug_setup.current_map_setup_map].with[display_item].as[<context.item>]>
                - flag <player> jug_setup.type:3
                - narrate "<&7>Please stand where the waiting lobby spawn should be and type in one of the following: <&nl><proc[jug_setup_proc].context[save|normal]><&7>: Save an auto-corrected location <&nl><proc[jug_setup_proc].context[exact|normal]><&7>: Save your exact location <&nl><proc[jug_setup_proc].context[cancel|normal]><&7>: Cancel the map creation." targets:<player>
            - else:
                - narrate "<&c>Display item must not be air."
jug_setup_proc:
    type: procedure
    definitions: arg|type
    debug: false
    script:
    - if <[type]> == normal:
        - determine <&a><element[/juggernaut<&sp>setup<&sp><[arg]>].on_click[/juggernaut<&sp>setup<&sp><[arg]>].type[SUGGEST_COMMAND].on_hover[<&7>Click<&sp>to<&sp>put<&sp>command<&sp>in<&sp>your<&sp>chat<&sp>bar.]>
    - else if <[type]> == input:
        - determine <&a><element[/juggernaut<&sp>setup<&sp><[arg]>].on_click[/juggernaut<&sp>setup].type[SUGGEST_COMMAND].on_hover[<&7>Click<&sp>to<&sp>put<&sp>command<&sp>in<&sp>your<&sp>chat<&sp>bar.]>
jug_deny_map_leave:
    type: world
    debug: false
    events:
        on player exits jug_*:
        - if <player.flag[juggernaut_data].get[map].if_null[null]> == <context.area.note_name.after[jug_]>:
            - if <player.flag[juggernaut_data].get[leave_spam].if_null[0]> < <proc[jug_config_read].context[leave_spam_limit]>:
                - narrate "<&c>Leaving is not allowed!"
                - wait 1t
                - teleport <player> <context.from>
                - flag <player> juggernaut_data.leave_spam:+:1
                - wait <proc[jug_config_read].context[leave_spam_rate]>s
                - if <player.flag[juggernaut_data.leave_spam].exists>:
                    - flag <player> juggernaut_data.leave_spam:-:1
            - else:
                - narrate "<&c>Teleported to map spawn!"
                - teleport <player> to:<server.flag[juggernaut_maps.<player.flag[juggernaut_data.map]>.spawn]>
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
    k: jug_kit_display_item
  procedural items:
    - define size 28
    - define pageMin <[size].mul[<player.flag[gui_page].sub[1]>].add[1]>
    - define pageMax <[size].mul[<player.flag[gui_page]>]>
    - define list <list>
    - if <player.has_permission[juggernaut.bypass.hidden]>:
        - if <server.flag[juggernaut_maps].keys.size> <= 0:
            - repeat 28:
                - define list:->:air
            - repeat 2:
                - define list <[list].include[black_stained_glass_pane[display_name=<&sp>]]>
            - determine <[list]>
        - define page <server.flag[juggernaut_maps].keys.get[<[pageMin]>].to[<[pageMax]>]>
    - else:
        - if <server.flag[juggernaut_maps].keys.filter_tag[<server.flag[juggernaut_maps.<[filter_value]>.hidden].exists.not>].size> <= 0:
            - repeat 28:
                - define list:->:air
            - repeat 2:
                - define list <[list].include[black_stained_glass_pane[display_name=<&sp>]]>
            - determine <[list]>
        - define page <server.flag[juggernaut_maps].keys.filter_tag[<server.flag[juggernaut_maps.<[filter_value]>.hidden].exists.not>].get[<[pageMin]>].to[<[pageMax]>]>
# Fills empty slots with player heads, with page number allowing those later im the list access
    - foreach <[page]>:
        - define item <server.flag[juggernaut_maps.<[value]>.display_item]>
        - adjust def:item display_name:<&f><&l><server.flag[juggernaut_maps.<[value]>.display_name].unescaped.parse_color>
        - adjust def:item flag:map:<[value]>
        - choose <server.flag[juggernaut_maps.<[value]>.game_data.phase]>:
            - case 0:
                - define phase <&a>Waiting
            - case 1:
                - define phase <&e>Starting
            - case 2:
                - define phase <&d>Ongoing
        - if <server.flag[juggernaut_maps.<[value]>.host_data].exists>:
            - define hosted "<&5>-<&sp><&d>Hosted by <server.flag[juggernaut_maps.<[value]>.host_data.host].name><&sp><&5>-<&nl>""
        - else:
            - define hosted:!
        - if <server.flag[juggernaut_maps.<[value]>.hidden].exists>:
            - define hidden <&nl><&c>*<&sp><&4>Hidden<&sp><&c>*
        - else:
            - define hidden:!
        - define click_type <list>
        - define click_type:->:<&nl>
        - if <server.flag[juggernaut_maps.<[value]>.game_data.phase]> == 0 || <server.flag[juggernaut_maps.<[value]>.game_data.phase]> == 1 || <player.flag[juggernaut_rejoin.id]> == <server.flag[juggernaut_maps.<[value]>.game_data.id]>:
            - define click_type:->:<&e>Left<&sp>Click:<&sp><&7>Join<&sp>Game
        - if <server.flag[juggernaut_maps.<[value]>.game_data.phase]> == 2:
            - define click_type:->:<&e>Right<&sp>Click:<&sp><&7>Spectate<&sp>Game
        - if <player.has_permission[juggernaut.host]> && <server.flag[juggernaut_maps.<[value]>.game_data.players].keys.size.if_null[0]> <= 0 && !<server.flag[juggernaut_maps.<[value]>.host_data.host].exists>:
            - define click_type:->:<&e>Shift<&sp>Left<&sp>Click:<&sp><&7>Host<&sp>Game
        - if <server.flag[juggernaut_maps.<[value]>.game_data.players].keys.size.if_null[0]> != 1:
            - define players <&7><server.flag[juggernaut_maps.<[value]>.game_data.players].keys.size.if_null[0]><&sp>Players<&nl>
        - else:
            - define players <&7><server.flag[juggernaut_maps.<[value]>.game_data.players].keys.size.if_null[0]><&sp>Player<&nl>
        - if <server.flag[juggernaut_maps.<[value]>.closed].exists>:
            - if <player.has_permission[juggernaut.bypass.closed]>:
                - define phase <&c>Closed<&sp><&7>(<[phase]><&7>)
            - else:
                - define phase <&c>Closed
                - define click_type:!
                - define players:!
        - adjust def:item "lore:<[players].if_null[]><[hosted].if_null[]><[phase]><[hidden].if_null[]><[click_type].separated_by[<&nl>].if_null[]><&nl><&nl><&7>Games Played: <server.flag[juggernaut_maps.<[value]>.games_played].if_null[0]>"
        - define list <[list].include[<[item]>]>
        - define click_type:!
        - define players:!
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
    - [] [g] [g] [t] [g] [k] [g] [g] []
jug_inv_click:
    type: world
    debug: false
    events:
        on player left clicks item_flagged:map in jug_map_selection_gui:
        - define map <context.item.flag[map]>
        - if <player.has_flag[juggernaut_data.in_game]>:
            - narrate "<&c>You are already in a game!"
            - stop
        - if <server.flag[juggernaut_maps.<[map]>.game_data.phase]> <= 1 && ( !<server.flag[juggernaut_maps.<[map]>.closed].exists> || <player.has_permission[juggernaut.bypass.closed]> ):
            - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.players.<player>].as[<map[].with[score].as[0].with[score_time].as[<util.time_now>]>]>
            - flag <player> juggernaut_data:<map[].with[map].as[<[map]>].with[ready_spam].as[0].with[leave_spam].as[0].with[in_game].as[true]>
            - teleport <player> to:<server.flag[juggernaut_maps.<[map]>.waiting_spawn]>
            - inventory clear d:<player.inventory>
            - heal
            - feed <player> amount:20
            - adjust <player> invulnerable:true
            - inventory set d:<player.inventory> o:jug_waiting_leave slot:9
            - inventory set d:<player.inventory> o:jug_waiting_spectate_item slot:8
            - if <server.flag[juggernaut_maps.<[map]>.host_data.host].exists>:
                - inventory set d:<player.inventory> o:jug_host_settings_item slot:7
            - inventory set d:<player.inventory> o:FIREWORK_STAR[display_name=<&7>Selected<&sp>Kit:<&sp><&l>Random] slot:5
            - inventory set d:<player.inventory> o:jug_custom_settings_item slot:3
            - inventory set d:<player.inventory> o:jug_waiting_ready slot:2
            - inventory set d:<player.inventory> o:jug_waiting_kit slot:1
            - if <server.flag[juggernaut_maps.<[map]>.game_data.saved_countdown].exists>:
                - if <server.flag[juggernaut_maps.<[map]>.game_data.saved_countdown]> != <server.flag[juggernaut_maps.<[map]>.game_data.countdown]>:
                    - flag server juggernaut_maps.<[map]>.game_data.countdown:<server.flag[juggernaut_maps.<[map]>.game_data.saved_countdown]>
                    - playsound <proc[jug_viewers].context[<[map]>]> sound:BLOCK_NOTE_BLOCK_PLING pitch:0.0 volume:1
            - narrate "<&a><&l>+ <&f><player.name> <&7>joined the match." targets:<proc[jug_viewers].context[<[map]>]>
            - run jug_ready_xp def:<[map]>
            - if <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size.if_null[0]> >= <proc[jug_config_read].context[mininum_players]> && <server.flag[juggernaut_maps.<[map]>.game_data.phase]> == 0 && !<server.flag[juggernaut_maps.<[map]>.host_data].exists>:
                - run jug_start_task def:<[map]>
        - else if <player.flag[juggernaut_rejoin.id]> == <server.flag[juggernaut_maps.<[map]>.game_data.id]> && <server.flag[juggernaut_maps.<[map]>.game_data.id].exists>:
            - run jug_rejoin_task def:<[map]>
        on player shift_left clicks item_flagged:map in jug_map_selection_gui:
        - if !<player.has_permission[juggernaut.host]>:
            - stop
        - define map <context.item.flag[map]>
        - if !<server.flag[juggernaut_maps.<[map]>].exists>:
            - narrate "<&c>Invalid map!"
            - stop
        - if <proc[jug_viewers].context[<[map]>].size.if_null[0]> > 0:
            - narrate "<&c>In order to host, there must be no players currently in the map."
            - stop
        - if <player.has_flag[juggernaut_data.in_game]>:
            - narrate "<&c>You cannot host if you are already in a game!"
            - stop
        - if <server.flag[juggernaut_maps.<[map]>.closed].exists> && !<player.has_permission[juggernaut.bypass.closed]>:
            - narrate "<&c>Sorry, that map is closed!"
            - stop
        - flag server juggernaut_maps.<[map]>.host_data.host:<player>
        - flag server juggernaut_maps.<[map]>.host_data.host_phase:closed
        - flag server juggernaut_maps.<[map]>.game_data.spectators:->:<player>
        - flag <player> juggernaut_data:<map[].with[map].as[<[map]>].with[ready_spam].as[0].with[leave_spam].as[0].with[in_game].as[true].with[is_host].as[true].with[spectator].as[true]>
        - teleport <player> to:<server.flag[juggernaut_maps.<[map]>.waiting_spawn]>
        - inventory clear d:<player.inventory>
        - heal
        - feed <player> amount:20
        - adjust <player> invulnerable:true
        - inventory set d:<player.inventory> o:jug_waiting_leave slot:9
        - inventory set d:<player.inventory> o:jug_waiting_unspectate_item slot:8
        - inventory set d:<player.inventory> o:jug_host_settings_item slot:1
        - inventory set d:<player.inventory> o:jug_custom_settings_item slot:7
        - run jug_ready_xp def:<[map]>
        on player right clicks item_flagged:map in jug_map_selection_gui:
        - define map <context.item.flag[map]>
        - if <player.has_flag[juggernaut_data.in_game]>:
            - narrate "<&c>You are already in a game!"
            - stop
        - if <server.flag[juggernaut_maps.<[map]>.game_data.phase]> == 2 && ( !<server.flag[juggernaut_maps.<[map]>.closed].exists> || <player.has_permission[juggernaut.bypass.closed]> ):
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
            - run jug_update_sidebar def:<[map]>|on
            - narrate "<&6><&l>+ <&f><player.name> <&7>is now spectating!" targets:<proc[jug_viewers].context[<[map]>]>
        on player clicks jug_tutorial_item in jug_map_selection_gui:
            - run jug_tutorial def:intro
            - inventory close d:<player.inventory>
        on player clicks jug_kit_display_item in jug_map_selection_gui:
            - inventory open d:jug_kit_selection_gui
        on player flagged:juggernaut_data.in_game clicks item in player*:
            - determine passively cancelled
        on player flagged:jug_login_tp joins:
        - teleport <player> to:<server.flag[juggernaut_spawn]>
        - cast remove glowing
        - cast remove invisibility
        - cast remove damage_resistance
        - heal <player>
        - flag <player> jug_login_tp:!
        on player flagged:juggernaut_data.is_host joins:
        - define map <player.flag[juggernaut_data.map]>
        - if <server.flag[juggernaut_maps.<[map]>.host_data.host]> != <player>:
            - flag <player> juggernaut_data.is_host:!
            - run jug_remove_player def:<[map]>|late_host_rejoin
        on player flagged:juggernaut_rejoin joins:
        - define map <player.flag[juggernaut_rejoin.map]>
        - if <player.flag[juggernaut_rejoin.id]> == <server.flag[juggernaut_maps.<[map]>.game_data.id].if_null[null]> && <server.flag[juggernaut_maps.<[map]>.game_data.id].exists>:
            - clickable jug_rejoin_task def:<[map]> player:<player> save:rejoin until:30s
            - narrate "<&7>Click <&a><&l><element[[here]].on_click[<entry[rejoin].command>]> <&7>to rejoin the Juggernaut game!"
jug_start_task:
    type: task
    definitions: map|countdown
    debug: false
    script:
    - if <server.flag[juggernaut_maps.<[map]>.game_data.phase]> != 0:
        - stop
    - if <[countdown].exists>:
        - define countdown:+:1
    - else:
        - define countdown:61
    - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.phase].as[1]>
    - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.countdown].as[<[countdown]>]>
    - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.saved_countdown].as[<[countdown]>]>
    - run jug_ready_xp def:<[map]>
    - while <server.flag[juggernaut_maps.<[map]>.game_data.countdown].if_null[1]> > 0 && <server.flag[juggernaut_maps.<[map]>.game_data.phase]> == 1:
        - if <server.flag[juggernaut_maps.<[map]>.game_data.phase]> == 1:
            - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.countdown].as[<server.flag[juggernaut_maps.<[map]>.game_data.countdown].sub[1]>]>
            - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.saved_countdown].as[<server.flag[juggernaut_maps.<[map]>.game_data.saved_countdown].sub[1]>]>
            - run jug_ready_xp def:<[map]>
            - if <server.flag[juggernaut_maps.<[map]>.game_data.countdown]> <= 10 && <server.flag[juggernaut_maps.<[map]>.game_data.countdown]> > 0:
                - playsound <proc[jug_viewers].context[<[map]>]> sound:BLOCK_TRIPWIRE_CLICK_ON pitch:0.0
                - if !<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_set].exists> && !<server.flag[juggernaut_maps.<[map]>.host_data.host].exists>:
                    - run jug_apply_custom_settings def:<[map]>
            - else if <server.flag[juggernaut_maps.<[map]>.game_data.countdown]> == 0:
                - playsound <proc[jug_viewers].context[<[map]>]> sound:ENTITY_PLAYER_LEVELUP pitch:1.0
                - if <server.flag[juggernaut_maps.<[map]>.host_data.host].exists> && <player.flag[juggernaut_custom_settings].exists>:
                    - flag server juggernaut_maps.<[map]>.game_data.custom_settings:<player.flag[juggernaut_custom_settings]>
                - flag server juggernaut_maps.<[map]>.game_data.phase:2
                - flag server juggernaut_maps.<[map]>.game_data.id:<util.random_uuid>
                - teleport <proc[jug_viewers].context[<[map]>]> to:<server.flag[juggernaut_maps.<[map]>.spawn]>
                - foreach <server.flag[juggernaut_maps.<[map]>.game_data.players].keys>:
                    - cast damage_resistance duration:<proc[jug_config_read].context[spawn_protection_duration|<[map]>]> amplifier:<proc[jug_config_read].context[spawn_protection_level|<[map]>].sub[1]> player:<[value]>
                    - run jug_give_kit player:<[value]>
                    - run jug_mana_start player:<[value]>
                    - adjust <[value]> invulnerable:false
                    - if <server.has_flag[juggernaut_maps.<[map]>.game_data.custom_settings.max_health]>:
                        - adjust <[value]> health_data:<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.max_health]>/<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.max_health]>
                    - flag <[value]> juggernaut_data.life_id:<util.random_uuid>
                    - flag server juggernaut_maps.<[map]>.game_data.players.<[value]>.score_history:<list>
                - define juggernaut <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.random>
                - flag server juggernaut_maps.<[map]>.game_data.juggernaut:<[juggernaut]>
                - flag <[juggernaut]> juggernaut_data.is_juggernaut:true
                - title 'title:<&c>You are the Juggernaut!' player:<[juggernaut]>
                - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.juggernaut_spawning].if_null[null]> != never:
                    - teleport <[juggernaut]> to:<server.flag[juggernaut_maps.<[map]>.jug_spawn]>
                - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.jug_scoring_method].if_null[null]> == interval:
                    - run jug_juggernaut_interval_task def:<[map]> player:<[juggernaut]>
                - if !<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.glowing_disabled].is_truthy>:
                    - cast glowing duration:10000s <player> no_icon hide_particles player:<[juggernaut]>
                - run jug_juggernaut_slowness def:<[map]> player:<[juggernaut]>
                - run JUG_KIT_DISPLAY def:update player:<[juggernaut]>
                - flag server juggernaut_maps.<[map]>.game_data.countdown:!
                - flag server juggernaut_maps.<[map]>.game_data.saved_countdown:!
                - flag server juggernaut_maps.<[map]>.game_data.ready_players:<list[]>
                - flag server juggernaut_maps.<[map]>.game_data.victory_condition:<proc[jug_config_read].context[victory_conditions|<[map]>]>
                - run jug_update_sidebar def:<[map]>|on
                - if <server.flag[juggernaut_maps.<[map]>.game_data.spectators].exists>:
                    - foreach <server.flag[juggernaut_maps.<[map]>.game_data.spectators]>:
                        - flag <[value]> juggernaut_data.hidden_from:<server.flag[juggernaut_maps.<[map]>.game_data.players].keys>
                        - execute as_server "cvstats send game_start arena:<[map]> game:juggernaut player:<[value].name>"
                        - adjust <[value]> hide_from_players:<[value].flag[juggernaut_data.hidden_from]>
                        - adjust <[value]> can_fly:true
                        - adjust <[value]> invulnerable:true
                        - inventory clear d:<[value].inventory>
                        - inventory set d:<[value].inventory> o:jug_waiting_leave slot:9
                        - inventory set d:<[value].inventory> o:jug_player_compass slot:1
                - flag server juggernaut_maps.<[map]>.game_data.time_started:<util.time_now>
                - execute as_server "cvstats send game_start arena:<[map]> game:juggernaut"
                - flag server juggernaut_maps.<[map]>.games_played:+:1
                - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings].exists>:
                    - narrate <proc[jug_settings_list_proc].context[map|<[map]>]> targets:<proc[jug_viewers].context[<[map]>]>
            - wait 1s
            - if <script[jug_start_task].queues.size> > 1:
                - stop
        - else:
            - stop
jug_rejoin_task:
    type: task
    definitions: map
    debug: false
    script:
    - if <player.flag[juggernaut_rejoin.id]> != <server.flag[juggernaut_maps.<[map]>.game_data.id]> && <server.flag[juggernaut_maps.<[map]>.game_data.id].exists>:
        - narrate "<&c>The match you left ended!"
        - stop
    - if <player.has_flag[juggernaut_data.in_game]>:
        - narrate "<&c>You can't rejoin a match from within one!"
        - stop
    - if <player.location.world> != <server.flag[juggernaut_spawn].world>:
        - narrate "<&c>You must be in the same world as Juggernaut to rejoin!"
        - stop
    - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.players.<player>].as[<map[].with[score].as[<player.flag[juggernaut_rejoin.score]>].with[score_time].as[<player.flag[juggernaut_rejoin.score_time]>]>]>
    - flag server juggernaut_maps.<[map]>.game_data.players.<player>.score_history:<player.flag[juggernaut_rejoin.score_history]>
    - flag <player> juggernaut_data:<map[].with[map].as[<[map]>].with[ready_spam].as[0].with[leave_spam].as[0].with[in_game].as[true]>
    - inventory clear d:<player.inventory>
    - run jug_update_sidebar def:<[map]>|on
    - narrate "<&a><&l>+ <&f><player.name> <&7>rejoined the match!" targets:<proc[jug_viewers].context[<[map]>]>
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
    - if <server.has_flag[juggernaut_maps.<[map]>.game_data.custom_settings.max_health]>:
        - adjust <player> health_data:<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.max_health]>/<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.max_health]>
    - inventory clear d:<player.inventory>
    - flag <player> gui_page:1
    - inventory open d:JUG_KIT_SELECTION_GUI
    - inventory set d:<player.inventory> o:jug_waiting_kit slot:1
    - if <player.has_flag[juggernaut_data.kit]>:
        - inventory set d:<player.inventory> o:<proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.gui_item]>[display_name=<&7>Selected<&sp>Kit:<&sp><&color[#<proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.primary_color]>]><&l><proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.display_name]>] slot:5
    - else:
        - inventory set d:<player.inventory> o:FIREWORK_STAR[display_name=<&7>Selected<&sp>Kit:<&sp><&l>Random] slot:5
    - adjust <player> fake_experience:1|<proc[jug_config_read].context[respawn_timer|<[map]>].round>
    - repeat <proc[jug_config_read].context[respawn_timer|<[map]>].round>:
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
    debug: false
    events:
        on player flagged:juggernaut_data.in_game damaged:
        - if <context.damager.exists>:
            - if <context.damager.has_flag[juggernaut_data.is_juggernaut]> || <context.entity.has_flag[juggernaut_data.is_juggernaut]>:
                - if ( !<context.damager.has_flag[juggernaut_data.dead]> || <context.cause> != entity_attack ) && !<context.damager.has_flag[juggernaut_data.spectator]> && <context.damager> != <context.entity>:
                    - if <context.damager> != <context.entity>:
                        - flag <context.entity> juggernaut_data.last_damager:<context.damager>
                    - if <context.projectile.exists> && <context.projectile.has_flag[sharpshooter]>:
                        - define ability <proc[jug_config_read].context[kits.<context.damager.flag[juggernaut_data.kit]>.inventory.<context.projectile.flag[kit_item]>.ability]>
                        - if <context.damager.has_flag[juggernaut_data.is_juggernaut]>:
                            - define player_type juggernaut
                        - else:
                            - define player_type player
                        - define maxDis <[ability.max_distance.<[player_type]>].if_null[<[ability.max_distance]>]>
                        - define minDam <[ability.min_damage_multiplier.<[player_type]>].if_null[<[ability.min_damage_multiplier]>]>
                        - define maxDam <[ability.max_damage_multiplier.<[player_type]>].if_null[<[ability.max_damage_multiplier]>]>
                        - define damageMultiplier <context.projectile.flag[shot_origin].distance[<context.entity.location>].div[<[maxDis].div[<[maxDam].sub[<[minDam]>]>]>].add[<[minDam]>].min[<[maxDam]>]>
                        - narrate "<&7>You dealt <&a><&l><[damageMultiplier].round_to_precision[0.01].substring[1,<[damageMultiplier].round_to_precision[0.01].index_of[.].add[2]>]>x <&7>more damage!"
                    - if <context.entity.flag[juggernaut_data.damage_multipliers.<context.damager>].exists>:
                        - define playerMultiplier <context.entity.flag[juggernaut_data.damage_multipliers.<context.damager>].add[1]>
                    - if <context.final_damage> <= 0:
                        - stop
                    - if <context.entity.has_flag[juggernaut_data.reflect_damage]>:
                        - hurt <context.final_damage.mul[<[damageMultiplier].if_null[1]>].mul[<[playerMultiplier].if_null[1]>].mul[<context.entity.flag[juggernaut_data.reflect_damage.damage_multiplier]>]> <context.damager> source:<context.entity>
                        - determine passively 0
                        # Knockback maybe should check if it was from a projectile? Maybe?
                        - adjust <context.damager> velocity:<context.damager.location.sub[<context.entity.location>].normalize.mul[<context.entity.flag[juggernaut_data.reflect_damage.knockback]>].with_y[<context.entity.flag[juggernaut_data.reflect_damage.knockback].mul[0.25]>]>
                    - if <context.entity.has_flag[juggernaut_data.is_juggernaut]>:
                        - determine passively <context.final_damage.mul[<[damageMultiplier].if_null[1]>].mul[<[playerMultiplier].if_null[1]>].mul[<proc[jug_jug_res_proc].context[<player.flag[juggernaut_data.map]>|<context.cause>]>]>
                    - else:
                        - determine passively <context.final_damage.mul[<[damageMultiplier].if_null[1]>].mul[<[playerMultiplier].if_null[1]>]>
                    - if <server.flag[juggernaut_maps.<player.flag[juggernaut_data.map]>.game_data.custom_settings.combo_mode].is_truthy>:
                        - wait 1t
                        - adjust <context.entity> no_damage_duration:0s
                - else:
                    - determine passively cancelled
            - else:
                - determine passively cancelled
        on player flagged:juggernaut_data.in_game shoots item_flagged:projectile_damage:
        - determine passively KEEP_ITEM
        - adjust <context.projectile> damage:<context.bow.flag[projectile_damage]>
        - adjust <context.projectile> pickup_status:DISALLOWED
        - if <context.bow.flag[ability_charge].if_null[null]> == sharpshooter:
            - if <player.item_in_hand> == <context.bow>:
                - inventory adjust slot:<player.held_item_slot> flag:ability_charge:!
                - inventory adjust slot:<player.held_item_slot> remove_enchantments:<list[].include[luck]>
            - else:
                - inventory adjust slot:41 flag:ability_charge:!
                - inventory adjust slot:41 remove_enchantments:<list[].include[luck]>
            - flag <context.projectile> sharpshooter:true
            - flag <context.projectile> kit_item:<context.bow.flag[kit_item]>
            - flag <context.projectile> shot_origin:<player.location>
        on arrow hits block:
        - if <context.projectile.has_flag[sharpshooter]> && <context.shooter.has_flag[juggernaut_data.in_game]>:
            - define player <context.shooter>
            - define item <context.projectile.flag[kit_item]>
            - define ability <proc[jug_config_read].context[kits.<[player].flag[juggernaut_data.kit]>.inventory.<[item]>.ability]>
            - if <[player].has_flag[juggernaut_data.is_juggernaut]>:
                - define player_type juggernaut
            - else:
                - define player_type player
            - if <[player].has_flag[juggernaut_data.ability_cooldowns.<[item]>]>:
                - flag <[player]> juggernaut_data.ability_cooldown_reductions.<[item]>:<[ability.miss_cooldown_reduction.<[player_type]>].if_null[<[ability.miss_cooldown_reduction]>]>
                - narrate "<&d><&l>✦ <&5>You have been granted an ability cooldown reduction of <&d><&l><[ability.miss_cooldown_reduction.<[player_type]>].if_null[<[ability.miss_cooldown_reduction]>].mul[100]><&pc> <&5>due to having missed your ability." targets:<[player]>
        on player flagged:juggernaut_data.in_game loads crossbow:
        - if <context.crossbow.has_flag[projectile_damage]>:
            - determine passively KEEP_ITEM
        on snowball flagged:snowball_slow hits player flagged:juggernaut_data.in_game:
        - if !<context.shooter.has_flag[juggernaut_data.is_juggernaut]> && !<player.has_flag[juggernaut_data.is_juggernaut]>:
            - stop
        - adjust <player> velocity:<context.projectile.velocity.normalize.mul[<context.projectile.flag[snowball_knockback]>].with_y[0.4]>
        - define life_id <player.flag[juggernaut_data.life_id]>
        - definemap attributes:
            generic_movement_speed:
                1:
                    operation: ADD_NUMBER
                    amount: <context.projectile.flag[snowball_slow]>
                    id: <util.random.uuid>
        - inventory adjust d:<player> slot:37 add_attribute_modifiers:<[attributes]>
        - if !<player.flag[juggernaut_data.damage_multipliers.<context.shooter>].exists>:
            - flag <player> juggernaut_data.damage_multipliers.<context.shooter>:0
        - flag <player> juggernaut_data.damage_multipliers.<context.shooter>:+:<context.projectile.flag[snowball_damage_bonus]>
        - wait <context.projectile.flag[snowball_slow_duration]>s
        - if <[life_id]> == <player.flag[juggernaut_data.life_id].if_null[0]>:
            - inventory adjust d:<player> slot:37 remove_attribute_modifiers:<list[<[attributes.generic_movement_speed.1.id]>]>
        - flag <player> juggernaut_data.damage_multipliers.<context.shooter>:-:<context.projectile.flag[snowball_damage_bonus]>
        - if <player.flag[juggernaut_data.damage_multipliers.<context.shooter>]> == 0:
            - flag <player> juggernaut_data.damage_multipliers.<context.shooter>:!
        on player flagged:juggernaut_data.in_game changes food level:
        - determine 20
        on player flagged:juggernaut_data.in_game heals because SATIATED:
        - define map <player.flag[juggernaut_data.map]>
        - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.regen_disabled].is_truthy>:
            - determine passively cancelled
        after player flagged:juggernaut_data.in_game heals:
        - run JUG_KIT_DISPLAY def:update player:<player>
        after player flagged:juggernaut_data.in_game damaged:
        - run JUG_KIT_DISPLAY def:update player:<context.entity>
        on player flagged:juggernaut_data.no_jump_list jumps:
        - determine passively cancelled
        on player flagged:juggernaut_data.in_game dies:
        - if <context.entity.has_flag[juggernaut_data.dead]> || <context.entity.has_flag[juggernaut_data.spectator]>:
            - determine passively cancelled
            - stop
        - if <server.flag[juggernaut_maps.<context.entity.flag[juggernaut_data.map]>.game_data.phase]> != 2:
            - determine passively cancelled
            - stop
        - define map <context.entity.flag[juggernaut_data.map]>
        - define jug_viewers <proc[jug_viewers].context[<[map]>]>
        - if <context.damager.exists> && <context.damager> != <context.entity> && <context.damager.is_player> && <context.damager.has_flag[juggernaut_data.in_game]>:
            - if <context.damager.has_flag[juggernaut_data.is_juggernaut]>:
                - run JUG_GIVE_POINTS_TASK def:<[map]>|juggernaut_kill|<context.entity> player:<context.damager>
                - execute as_server "cvstats send pvp_kill arena:<[map]> game:juggernaut kit:<context.damager.flag[juggernaut_data.kit]> player:<context.damager.name>"
                - execute as_server "cvstats send pvp_death arena:<[map]> game:juggernaut kit:<context.entity.flag[juggernaut_data.kit]> player:<context.entity.name>"
                #- flag server juggernaut_maps.<[map]>.game_data.players.<context.damager>.score:+:<proc[jug_config_read].context[juggernaut_kill_points|<[map]>]>
                #- flag server juggernaut_maps.<[map]>.game_data.players.<context.damager>.score_time:<util.time_now>
                - narrate "<&f><&l>× <&f><context.entity.name> <&7>was killed by <&c><context.damager.name>" targets:<[jug_viewers]>
                - narrate "<&a><&l>⚑ <&c><context.damager.name> <&7>now has <&a><server.flag[juggernaut_maps.<[map]>.game_data.players.<context.damager>.score]> <&7>point<proc[jug_plural_s].context[<server.flag[juggernaut_maps.<[map]>.game_data.players.<context.damager>.score]>]>" targets:<[jug_viewers]>
                - run jug_update_sidebar def:<[map]>|on|<context.damager>
            - else if <context.entity.has_flag[juggernaut_data.is_juggernaut]>:
                - narrate "<&c><&l>× <&c><context.entity.name> <&7>was killed by <&f><context.damager.name>" targets:<[jug_viewers]>
                - execute as_server "cvstats send pvp_kill arena:<[map]> game:juggernaut kit:<context.damager.flag[juggernaut_data.kit]> player:<context.damager.name>"
                - execute as_server "cvstats send pvp_death arena:<[map]> game:juggernaut kit:<context.entity.flag[juggernaut_data.kit]> player:<context.entity.name>"
                - ~run jug_new_juggernaut_task def:<context.damager>|<[map]> player:<context.entity>
        - else if <context.entity.has_flag[juggernaut_data.is_juggernaut]>:
            - if <context.entity.flag[juggernaut_data.last_damager].exists> && <context.entity.flag[juggernaut_data.last_damager]> != <context.entity> && <context.entity.flag[juggernaut_data.last_damager].is_player> && <context.entity.flag[juggernaut_data.last_damager].has_flag[juggernaut_data.in_game]>:
                - define killer <context.entity.flag[juggernaut_data.last_damager]>
                - execute as_server "cvstats send pvp_kill arena:<[map]> game:juggernaut kit:<[killer].flag[juggernaut_data.kit]> player:<[killer].name>"
                - execute as_server "cvstats send pvp_death arena:<[map]> game:juggernaut kit:<context.entity.flag[juggernaut_data.kit]> player:<context.entity.name>"
                - narrate "<&c><&l>× <&c><context.entity.name> <&7>was killed by <&f><[killer].name>" targets:<[jug_viewers]>
                - ~run jug_new_juggernaut_task def:<[killer]>|<[map]> player:<context.entity>
            - else if <context.entity.location.find_entities[player].within[300].filter_tag[<[filter_value].has_flag[juggernaut_data.in_game].and[<[filter_value].has_flag[juggernaut_data.dead].not.and[<[filter_value].equals[<context.entity>].not.and[<[filter_value].has_flag[juggernaut_data.spectator].not>]>]>]>].first.exists>:
                - define killer <context.entity.location.find_entities[player].within[300].filter_tag[<[filter_value].has_flag[juggernaut_data.in_game].and[<[filter_value].has_flag[juggernaut_data.dead].not.and[<[filter_value].equals[<context.entity>].not.and[<[filter_value].has_flag[juggernaut_data.spectator].not>]>]>]>].first>
                - execute as_server "cvstats send pvp_death arena:<[map]> game:juggernaut kit:<context.entity.flag[juggernaut_data.kit]> player:<context.entity.name>"
                - narrate "<&c><&l>× <&c><context.entity.name> <&7>died!" targets:<[jug_viewers]>
                - ~run jug_new_juggernaut_task def:<[killer]>|<[map]> player:<context.entity>
            - else if <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.exclude[<context.entity>].size> > 0:
                - define killer <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.exclude[<context.entity>].random>
                - execute as_server "cvstats send pvp_death arena:<[map]> game:juggernaut kit:<context.entity.flag[juggernaut_data.kit]> player:<context.entity.name>"
                - narrate "<&c><&l>× <&c><context.entity.name> <&7>died!" targets:<[jug_viewers]>
                - ~run jug_new_juggernaut_task def:<[killer]>|<[map]> player:<context.entity>
            - else:
                - execute as_server "cvstats send pvp_death arena:<[map]> game:juggernaut kit:<context.entity.flag[juggernaut_data.kit]> player:<context.entity.name>"
                - narrate "<&c><&l>× <&c><context.entity.name> <&7>died!" targets:<proc[jug_viewers].context[<[map]>]>
        - else:
            - narrate "<&f><&l>× <&e><context.entity.name> <&7>died!" targets:<proc[jug_viewers].context[<[map]>]>
        - playsound <context.entity.location> sound:entity_drowned_death pitch:0.75 volume:5
        - teleport <context.entity> to:<server.flag[juggernaut_maps.<[map]>.spawn]>
        - if <player.is_online>:
            - run JUG_KIT_DISPLAY def:remove
        - heal <context.entity>
        - determine passively cancelled
        - if <context.entity.has_flag[juggernaut_data.in_game]>:
            - run jug_mana_end player:<context.entity>
            - flag <context.entity> juggernaut_data.dead:true
            - flag <context.entity> juggernaut_data.dead_countdown:true
            - flag <context.entity> juggernaut_data.last_damager:!
            - flag <context.entity> juggernaut_data.hidden_from:<server.flag[juggernaut_maps.<[map]>.game_data.players].keys>
            - flag <context.entity> juggernaut_data.life_id:!
            - adjust <context.entity> hide_from_players:<player.flag[juggernaut_data.hidden_from]>
            - adjust <context.entity> can_fly:true
            - adjust <player> invulnerable:true
            - adjust <context.entity> clear_body_arrows
            - inventory clear d:<context.entity.inventory>
            - flag <player> gui_page:1
            - if !<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.random_only].if_null[false]>:
                - flag <context.entity> juggernaut_data.kit_selection:true
                - inventory open d:JUG_KIT_SELECTION_GUI
                - inventory set d:<context.entity.inventory> o:jug_waiting_kit slot:1
                - inventory set d:<player.inventory> o:<proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.gui_item]>[display_name=<&7>Selected<&sp>Kit:<&sp><&color[#<proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.primary_color]>]><&l><proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.display_name]>] slot:5
            - else:
                - flag <player> juggernaut_data.kit:!
            - adjust <context.entity> fake_experience:1|<proc[jug_config_read].context[respawn_timer|<[map]>].round>
            - define respawn_timer:<proc[jug_config_read].context[respawn_timer|<[map]>].round>
            - repeat <[respawn_timer]>:
                - if <context.entity.has_flag[juggernaut_data.in_game]>:
                    - adjust <context.entity> fake_experience:<[value].sub[<[respawn_timer].add[1]>].abs.div[<[respawn_timer]>]>|<[value].sub[<[respawn_timer].add[1]>].abs>
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
    debug: false
    script:
    - define map <player.flag[juggernaut_data.map]>
    - flag <player> juggernaut_data.dead:!
    - flag <player> juggernaut_data.life_id:<util.random_uuid>
    - if <player.has_flag[juggernaut_data.is_juggernaut]> && <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.jug_scoring_method].if_null[null]> == interval:
        - run jug_juggernaut_interval_task def:<[map]> player:<player>
    - adjust <player> show_to_players:<player.flag[juggernaut_data.hidden_from]>
    - flag <player> juggernaut_data.hidden_from:!
    - adjust <player> can_fly:false
    - adjust <player> fall_distance:0
    - adjust <player> invulnerable:false
    - adjust <player> fake_experience
    - teleport <player> to:<server.flag[juggernaut_maps.<player.flag[juggernaut_data.map]>.spawn]>
    - run jug_give_kit player:<player>
    - run jug_mana_start player:<player>
    - title "title:<&e>You have respawned!" "subtitle:<&7>Kit: <&color[#<proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.primary_color]>]><&l><proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.display_name]>" fade_in:0.5s stay:2s fade_out:1s
    - cast damage_resistance duration:<proc[jug_config_read].context[spawn_protection_duration|<[map]>]> amplifier:<proc[jug_config_read].context[spawn_protection_level|<[map]>].sub[1]>
jug_magic_event:
    type: world
    debug: false
    events:
        on player flagged:juggernaut_data.in_game right clicks block with:item_flagged:magic_damage:
        - if <player.flag[juggernaut_data.mana]> >= 15:
            - ratelimit <player> 1s
            - define particleCount:<context.item.flag[magic_range].mul[5]>
            - define vector:<player.eye_location>
            - run jug_mana_use def:15 player:<player>
            - repeat <[particleCount]>:
                - playeffect effect:<context.item.flag[magic_particle]> at:<[vector].forward[<[value].mul[0.2]>]> offset:0,0,0 visibility:200
                - if <[vector].forward[<[value].mul[0.2]>].material.name> != air && <[vector].forward[<[value].mul[0.2]>].material.name> != water:
                    - stop
                - hurt <context.item.flag[magic_damage]> <[vector].forward[<[value].mul[0.2]>].find_entities[player].within[0.01]> source:<player> cause:ENTITY_ATTACK
                - define wait_time:+:<context.item.flag[magic_speed].div[<context.item.flag[magic_range]>].mul[0.2]>
                - if <[wait_time]> >= 0.05:
                    - wait <context.item.flag[magic_speed].div[<context.item.flag[magic_range]>].mul[0.2].round_up_to_precision[0.05]>s
                    - define count:+:1
                    - define wait_time:-:<context.item.flag[magic_speed].div[<context.item.flag[magic_range]>].mul[0.2].round_up_to_precision[0.05]>
        - else:
            - narrate "<&c>You don't have enough mana for that!"
jug_mana_regen:
    type: task
    debug: false
    script:
    - define life_id:<player.flag[juggernaut_data.life_id].if_null[0]>
    - define map <player.flag[juggernaut_data.map]>
    - flag <player> juggernaut_data.mana_regen:true
    - wait <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.mana_multiplier].mul[0.2].if_null[0.2]>s
    - if <player.flag[juggernaut_data.life_id].if_null[0]> == <[life_id]>:
        - flag <player> juggernaut_data.mana_recharge:-:1
        - run jug_mana_restore player:<player>
    - else:
        - stop
    - if <player.flag[juggernaut_data.mana_recharge]> > 0:
        - run jug_mana_regen player:<player>
    - else:
        - flag <player> juggernaut_data.mana_regen:!
jug_mana_use:
    type: task
    debug: false
    definitions: amount
    script:
    - flag <player> juggernaut_data.mana:-:<[amount]>
    - flag <player> juggernaut_data.mana_recharge:+:<[amount]>
    - run jug_mana_update player:<player>
    - if !<player.flag[juggernaut_data.mana_regen].exists>:
        - run jug_mana_regen player:<player>
jug_mana_restore:
    type: task
    debug: false
    script:
    - flag <player> juggernaut_data.mana:+:1
    - run jug_mana_update player:<player>
jug_mana_update:
    type: task
    debug: false
    script:
    - adjust <player> fake_experience:<player.flag[juggernaut_data.mana].div[100]>|<player.flag[juggernaut_data.mana]>
jug_mana_start:
    type: task
    debug: false
    script:
    - if <proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.kit_type].if_null[null]> == magic:
        - flag <player> juggernaut_data.mana:100
        - flag <player> juggernaut_data.mana_recharge:0
        - run jug_mana_update player:<player>
jug_mana_end:
    type: task
    debug: false
    script:
    - if <proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.kit_type].if_null[null]> == magic:
        - flag <player> juggernaut_data.mana:!
        - flag <player> juggernaut_data.mana_recharge:!
        - flag <player> juggernaut_data.mana_regen:!
        - adjust <player> fake_experience
jug_leave_lobby:
    type: world
    debug: false
    events:
        on player right clicks block with:jug_waiting_leave:
        - run jug_remove_player def:<player.flag[juggernaut_data].get[map]>
        on player flagged:juggernaut_data.in_game quits:
        - run jug_remove_player def:<player.flag[juggernaut_data].get[map]>
        on player right clicks block with:jug_waiting_spectate_item:
        - determine passively cancelled
        - if <player.flag[juggernaut_data.ready_spam]> >= <proc[jug_config_read].context[ready_spam_limit]>:
            - narrate "<&c>Please slow down!"
            - stop
        - define map <player.flag[juggernaut_data.map]>
        - define was_ready <server.flag[juggernaut_maps.<[map]>.game_data.ready_players].contains[<player>]>
        - if !<player.has_flag[juggernaut_data.is_host]>:
            - ~run jug_remove_player def:<player.flag[juggernaut_data].get[map]>|setspectate
        - flag server juggernaut_maps.<[map]>.game_data.players.<player>:!
        - flag server juggernaut_maps.<[map]>.game_data.spectators:->:<player>
        - flag <player> juggernaut_data.map:<[map]>
        - flag <player> juggernaut_data.spectator:true
        - flag <player> juggernaut_data.in_game:true
        - inventory clear d:<player.inventory>
        - inventory set d:<player.inventory> o:jug_waiting_leave slot:9
        - inventory set d:<player.inventory> o:jug_waiting_unspectate_item slot:8
        - if <player.has_flag[juggernaut_data.is_host]>:
            - inventory set d:<player.inventory> o:jug_host_settings_item slot:1
            - inventory set d:<player.inventory> o:jug_custom_settings_item slot:7
        - else:
            - if <server.flag[juggernaut_maps.<[map]>.host_data.host].exists>:
                - inventory set d:<player.inventory> o:jug_host_settings_item slot:7
                - inventory set d:<player.inventory> o:jug_custom_settings_item slot:6
            - else:
                - inventory set d:<player.inventory> o:jug_custom_settings_item slot:7
        - narrate "<&6><&l>- <&f><player.name> <&7>is now spectating." targets:<proc[jug_viewers].context[<player.flag[juggernaut_data.map]>]>
        - run jug_ready_xp def:<[map]>
        - wait 1t
        - flag <player> juggernaut_data.ready_spam:+:1
        - wait <proc[jug_config_read].context[ready_spam_rate]>s
        - if <player.flag[juggernaut_data.ready_spam].exists>:
            - flag <player> juggernaut_data.ready_spam:-:1
        on player right clicks block with:jug_waiting_unspectate_item:
        - determine passively cancelled
        - if <player.flag[juggernaut_data.ready_spam]> >= <proc[jug_config_read].context[ready_spam_limit]>:
            - narrate "<&c>Please slow down!"
            - stop
        - if !<player.flag[juggernaut_data.spectator].exists>:
            - narrate "<&c>Error: You should be spectating but you weren't. Please report this to staff."
            - stop
        - define map <player.flag[juggernaut_data.map]>
        - if !<player.has_flag[juggernaut_data.is_host]>:
            - ~run jug_remove_player def:<player.flag[juggernaut_data].get[map]>|setspectate
        - flag <player> juggernaut_data.spectator:!
        - flag server juggernaut_maps.<[map]>.game_data.spectators:<-:<player>
        - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.players.<player>].as[<map[].with[score].as[0].with[score_time].as[<util.time_now>]>]>
        - if <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size.if_null[0]> >= <proc[jug_config_read].context[mininum_players]> && <server.flag[juggernaut_maps.<[map]>.game_data.phase]> == 0  && !<server.flag[juggernaut_maps.<[map]>.host_data].exists>:
            - run jug_start_task def:<[map]>
        - flag <player> juggernaut_data.map:<[map]>
        - flag <player> juggernaut_data.in_game:true
        - narrate "<&e><&l>+ <&f><player.name> <&7>is now playing." targets:<proc[jug_viewers].context[<player.flag[juggernaut_data.map]>]>
        - inventory clear d:<player.inventory>
        - inventory set d:<player.inventory> o:jug_waiting_leave slot:9
        - inventory set d:<player.inventory> o:jug_waiting_spectate_item slot:8
        - if <player.flag[juggernaut_data.kit].exists> && <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.random_only].exists>:
            - flag <player> juggernaut_data.kit:!
            - narrate "<&c>The host has enabled random only, which means your kit selection has been reset!" targets:<player>
        - if <player.flag[juggernaut_data.kit].exists>:
            - inventory set d:<player.inventory> o:<proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.gui_item]>[display_name=<&7>Selected<&sp>Kit:<&sp><&color[#<proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.primary_color]>]><&l><proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.display_name]>] slot:5
        - else:
            - inventory set d:<player.inventory> o:FIREWORK_STAR[display_name=<&7>Selected<&sp>Kit:<&sp><&l>Random] slot:5
        - if <player.has_flag[juggernaut_data.is_host]>:
            - inventory set d:<player.inventory> o:jug_host_settings_item slot:1
            - inventory set d:<player.inventory> o:jug_waiting_kit slot:2
            - inventory set d:<player.inventory> o:jug_waiting_ready slot:3
            - inventory set d:<player.inventory> o:jug_custom_settings_item slot:7
        - else:
            - inventory set d:<player.inventory> o:jug_waiting_kit slot:1
            - inventory set d:<player.inventory> o:jug_waiting_ready slot:2
            - inventory set d:<player.inventory> o:jug_custom_settings_item slot:3
            - if <server.flag[juggernaut_maps.<[map]>.host_data.host].exists>:
                - inventory set d:<player.inventory> o:jug_host_settings_item slot:7
        - run jug_ready_xp def:<[map]>
        - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.banned_kits].contains[<player.flag[juggernaut_data.kit].if_null[]>].if_null[false]>:
            - narrate "<&c>The kit you had selected has been disabled by the host! You have been reset back to using a random kit."
            - flag <player> juggernaut_data.kit:!
            - inventory set d:<player.inventory> o:FIREWORK_STAR[display_name=<&7>Selected<&sp>Kit:<&sp><&l>Random] slot:5
        - wait 1t
        - flag <player> juggernaut_data.ready_spam:+:1
        - wait <proc[jug_config_read].context[ready_spam_rate]>s
        - if <player.flag[juggernaut_data.ready_spam].exists>:
            - flag <player> juggernaut_data.ready_spam:-:1
        on server start:
        - foreach <server.flag[juggernaut_maps]>:
            - run jug_stop_game def:<[key]>
        - flag server juggernaut_clear_stands:true
        on player right clicks block with:jug_waiting_kit:
        - if !<player.has_flag[juggernaut_data.kit_selection]>:
            - flag <player> gui_page:1
            - inventory open d:JUG_KIT_SELECTION_GUI
        on player right clicks block with:jug_waiting_ready:
        - define map <player.flag[juggernaut_data.map]>
        - if <server.flag[juggernaut_maps.<[map]>.game_data.ready_players].contains[<player>].if_null[false]>:
            - narrate "<&c>You are already ready!"
            - stop
        - if <player.flag[juggernaut_data].get[ready_spam]> < <proc[jug_config_read].context[ready_spam_limit]>:
            - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<player.flag[juggernaut_data].get[map]>.game_data.ready_players].as[<server.flag[juggernaut_maps.<player.flag[juggernaut_data].get[map]>.game_data.ready_players].include[<player>]>]>
            - run jug_ready_xp def:<player.flag[juggernaut_data].get[map]>
            - narrate "<&a><&l>+ <&e><player.name> <&6>is ready. <&e>(<server.flag[juggernaut_maps.<player.flag[juggernaut_data].get[map]>.game_data.ready_players].size>/<server.flag[juggernaut_maps.<player.flag[juggernaut_data].get[map]>.game_data.players].keys.size.if_null[0]>)" targets:<proc[jug_viewers].context[<player.flag[juggernaut_data.map]>]>
            - if <server.flag[juggernaut_maps.<player.flag[juggernaut_data].get[map]>.game_data.ready_players].size> == <server.flag[juggernaut_maps.<player.flag[juggernaut_data].get[map]>.game_data.players].keys.size.if_null[0]> && <server.flag[juggernaut_maps.<player.flag[juggernaut_data].get[map]>.game_data.saved_countdown].if_null[0]> > 3:
                - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<player.flag[juggernaut_data].get[map]>.game_data.countdown].as[3]>
                - run jug_ready_xp def:<player.flag[juggernaut_data].get[map]>
                - playsound <proc[jug_viewers].context[<[map]>]> sound:BLOCK_NOTE_BLOCK_PLING pitch:2.0
            - wait 1t
            - if <player.has_flag[juggernaut_data.is_host]>:
                - inventory set d:<player.inventory> o:jug_waiting_unready slot:3
            - else:
                - inventory set d:<player.inventory> o:jug_waiting_unready slot:2
            - flag <player> juggernaut_data.ready_spam:+:1
            - wait <proc[jug_config_read].context[ready_spam_rate]>s
            - if <player.flag[juggernaut_data.ready_spam].exists>:
                - flag <player> juggernaut_data.ready_spam:-:1
        - else:
            - narrate "<&c>Please slow down!"
        on player right clicks block with:jug_waiting_unready:
        - define map <player.flag[juggernaut_data.map]>
        - if !<server.flag[juggernaut_maps.<[map]>.game_data.ready_players].contains[<player>]>:
            - narrate "<&c>You are already not ready!"
        - if <player.flag[juggernaut_data].get[ready_spam]> < <proc[jug_config_read].context[ready_spam_limit]>:
            - if <server.flag[juggernaut_maps.<[map]>.game_data.countdown]> != <server.flag[juggernaut_maps.<[map]>.game_data.saved_countdown]>:
                - playsound <proc[jug_viewers].context[<[map]>]> sound:BLOCK_NOTE_BLOCK_PLING pitch:0.0 volume:1
            - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<player.flag[juggernaut_data].get[map]>.game_data.ready_players].as[<server.flag[juggernaut_maps.<player.flag[juggernaut_data].get[map]>.game_data.ready_players].exclude[<player>]>]>
            - narrate "<&c><&l>- <&e><player.name> <&6>is no longer ready. <&e>(<server.flag[juggernaut_maps.<player.flag[juggernaut_data].get[map]>.game_data.ready_players].size>/<server.flag[juggernaut_maps.<player.flag[juggernaut_data].get[map]>.game_data.players].keys.size.if_null[0]>)" targets:<proc[jug_viewers].context[<player.flag[juggernaut_data.map]>]>
            - if <server.flag[juggernaut_maps.<[map]>.game_data.saved_countdown].exists>:
                - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<player.flag[juggernaut_data].get[map]>.game_data.countdown].as[<server.flag[juggernaut_maps.<player.flag[juggernaut_data].get[map]>.game_data.saved_countdown]>]>
            - run jug_ready_xp def:<player.flag[juggernaut_data].get[map]>
            - wait 1t
            - if <player.has_flag[juggernaut_data.is_host]>:
                - inventory set d:<player.inventory> o:jug_waiting_ready slot:3
            - else:
                - inventory set d:<player.inventory> o:jug_waiting_ready slot:2
            - flag <player> juggernaut_data.ready_spam:+:1
            - wait <proc[jug_config_read].context[ready_spam_rate]>s
            - if <player.flag[juggernaut_data.ready_spam].exists>:
                - flag <player> juggernaut_data.ready_spam:-:1
        - else:
            - narrate "<&c>Please slow down!"
jug_remove_player:
    type: task
    definitions: map|type
    debug: false
    script:
    - if !<player.is_online>:
        - flag <player> jug_login_tp:true
    - else if <player.has_flag[juggernaut_data.is_host]> && <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.exclude[<player>].size.if_null[0]> >= <proc[jug_config_read].context[mininum_players]>:
        - narrate "<&c>You must stop the hosted game before you can leave! <&nl>Command: <element[<&6>/juggernaut host classic -s].on_click[/juggernaut host classic -s].type[SUGGEST_COMMAND]> <&nl><&4><&l>(!!!) <&c>Stopping a hosted game completely ends the current game!"
        - stop
    - else if <player.has_flag[juggernaut_data.is_host]>:
        - run jug_stop_hosting def:<[map]>
        - stop
    - if !<[type].exists>:
        - define type null
    - if <[type]> == late_host_rejoin:
        - goto late_host_rejoin1
    - if !<player.has_flag[juggernaut_data.spectator]> && <server.flag[juggernaut_maps.<[map]>.game_data.phase].if_null[0]> > 1:
        - define rejoin_data <map[]>
        - define rejoin_data.id:<server.flag[juggernaut_maps.<[map]>.game_data.id]>
        - define rejoin_data.map:<[map]>
        - define rejoin_data.score:<server.flag[juggernaut_maps.<[map]>.game_data.players.<player>.score]>
        - define rejoin_data.score_time:<server.flag[juggernaut_maps.<[map]>.game_data.players.<player>.score_time]>
        - define rejoin_data.score_history:<server.flag[juggernaut_maps.<[map]>.game_data.players.<player>.score_history]>
        - flag <player> juggernaut_rejoin:<[rejoin_data]>
    - if <server.flag[juggernaut_maps.<[map]>.game_data.ready_players].size.if_null[0]> > 0:
        - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.ready_players].as[<server.flag[juggernaut_maps.<[map]>.game_data.ready_players].exclude[<player>]>]>
    - if <server.flag[juggernaut_maps.<[map]>.game_data.players].contains[<player>].if_null[false]>:
        - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_exclude[<[map]>.game_data.players.<player>]>
    - else if <server.flag[juggernaut_maps.<[map]>.game_data.spectators].contains[<player>].if_null[false]>:
        - flag server juggernaut_maps.<[map]>.game_data.spectators:<-:<player>
    - if !<server.flag[juggernaut_maps.<[map]>.host_data].exists>:
        - if <server.flag[juggernaut_maps.<[map]>.game_data.ready_players].size.if_null[0]> == <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size.if_null[0]> && <server.flag[juggernaut_maps.<[map]>.game_data.saved_countdown].if_null[0]> > 3 && <server.flag[juggernaut_maps.<[map]>.game_data.countdown].if_null[0]> > 3:
            - flag server juggernaut_maps.<[map]>.game_data.countdown:3
            - playsound <proc[jug_viewers].context[<[map]>]> sound:BLOCK_NOTE_BLOCK_PLING pitch:2.0
        - else if <server.flag[juggernaut_maps.<[map]>.game_data.ready_players].size.if_null[0]> <= <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size.if_null[0]> && <server.flag[juggernaut_maps.<[map]>.game_data.saved_countdown].if_null[0]> != <server.flag[juggernaut_maps.<[map]>.game_data.countdown].if_null[0]>:
            - flag server juggernaut_maps.<[map]>.game_data.countdown:<server.flag[juggernaut_maps.<[map]>.game_data.saved_countdown].if_null[0]>
            - playsound <proc[jug_viewers].context[<[map]>]> sound:BLOCK_NOTE_BLOCK_PLING pitch:0.0 volume:1
    - if <[type]> == end_game:
        - goto late_host_rejoin1
    - if <player.has_flag[juggernaut_data.is_juggernaut]> && <server.flag[juggernaut_maps.<[map]>.game_data.phase].if_null[0]> >= 2 && <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size.if_null[0]> > 0:
        - define jug_viewers <proc[jug_viewers].context[<[map]>]>
        - if <player.flag[juggernaut_data.last_damager].exists> && <player.flag[juggernaut_data.last_damager]> != <player> && <player.flag[juggernaut_data.last_damager].is_player>:
            - define killer <player.flag[juggernaut_data.last_damager]>
            - narrate "<&c><&l>- <&c><player.name> <&7>left the match." targets:<[jug_viewers]>
            - ~run jug_new_juggernaut_task def:<[killer]>|<[map]> player:<player>
        - else if <player.location.find_entities[player].within[300].filter_tag[<[filter_value].has_flag[juggernaut_data.in_game].and[<[filter_value].has_flag[juggernaut_data.dead].not.and[<[filter_value].equals[<player>].not.and[<[filter_value].has_flag[juggernaut_data.spectator].not>]>]>]>].first.exists>:
            - define killer <player.location.find_entities[player].within[300].filter_tag[<[filter_value].has_flag[juggernaut_data.in_game].and[<[filter_value].has_flag[juggernaut_data.dead].not.and[<[filter_value].equals[<player>].not.and[<[filter_value].has_flag[juggernaut_data.spectator].not>]>]>]>].first>
            - narrate "<&c><&l>- <&c><player.name> <&7>left the match." targets:<[jug_viewers]>
            - ~run jug_new_juggernaut_task def:<[killer]>|<[map]> player:<player>
        - else if <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.exclude[<player>].exists>:
            - define killer <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.exclude[<player>].random>
            - narrate "<&c><&l>- <&c><player.name> <&7>left the match." targets:<[jug_viewers]>
            - ~run jug_new_juggernaut_task def:<[killer]>|<[map]> player:<player>
        - else:
            - narrate "<&c><&l>- <&c><player.name> <&7>left the match." targets:<proc[jug_viewers].context[<[map]>]>
            - run jug_update_sidebar def:<[map]>|on
    - else if <server.flag[juggernaut_maps.<[map]>.game_data.phase]> >= 2:
        - narrate "<&c><&l>- <&f><player.name> <&7>left the match." targets:<proc[jug_viewers].context[<[map]>]>
        - run jug_update_sidebar def:<[map]>|on
    - else if <server.flag[juggernaut_maps.<[map]>.game_data.phase]> <= 1:
        - narrate "<&c><&l>- <&f><player.name> <&7>left the match." targets:<proc[jug_viewers].context[<[map]>]>
    - mark late_host_rejoin1
    - if <player.has_flag[juggernaut_data.hidden_from]>:
        - adjust <player> show_to_players:<player.flag[juggernaut_data.hidden_from]>
    - adjust <player> can_fly:false
    - adjust <player> invulnerable:false
    - adjust <player> max_health:20
    - if <player.is_online>:
        - run JUG_KIT_DISPLAY def:remove
    - define ready_spam <player.flag[juggernaut_data.ready_spam].if_null[0]>
    - run jug_update_custom_settings_vote def:<[map]>
    - if <[type]> != setspectate:
        - flag <player> juggernaut_data:!
    - if <[type]> == setspectate:
        - flag <player> juggernaut_data.ready_spam:<[ready_spam]>
    - inventory clear d:<player.inventory>
    - execute as_server "sidebar hide player:<player.name>"
    - if <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size.if_null[0]> < <proc[jug_config_read].context[mininum_players]>:
        - if !<server.flag[juggernaut_maps.<[map]>.host_data.host].exists> || <server.flag[juggernaut_maps.<[map]>.game_data.phase]> >= 2:
            - if <server.flag[juggernaut_maps.<[map]>.game_data.phase]> <= 1:
                - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_exclude[<[map]>.game_data.countdown]>
                - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_exclude[<[map]>.game_data.saved_countdown]>
                - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.phase].as[0]>
                - run jug_stop_game def:<[map]>
            - else if <server.flag[juggernaut_maps.<[map]>.game_data.phase]> == 2:
                - run jug_stop_game def:<[map]>
        - else if !<server.flag[juggernaut_maps.<[map]>.host_data.host].exists> && <server.flag[juggernaut_maps.<[map]>.game_data.phase]> == 1:
            - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_exclude[<[map]>.game_data.countdown]>
            - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_exclude[<[map]>.game_data.saved_countdown]>
            - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.phase].as[0]>
        - else if <server.flag[juggernaut_maps.<[map]>.host_data.host].exists> && <server.flag[juggernaut_maps.<[map]>.game_data.phase]> <= 1:
            - if <server.flag[juggernaut_maps.<[map]>.host_data.host].is_online>:
                - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_exclude[<[map]>.game_data.countdown]>
                - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_exclude[<[map]>.game_data.saved_countdown]>
                - flag server juggernaut_maps:<server.flag[juggernaut_maps].deep_with[<[map]>.game_data.phase].as[0]>
            - else:
                - run jug_stop_hosting def:<[map]>
    - adjust <player> fake_experience
    - run jug_ready_xp def:<[map]>
    - if <[type]> != setspectate:
        - teleport <player> to:<server.flag[juggernaut_spawn]>
    - cast remove glowing
    - cast remove invisibility
    - cast remove damage_resistance
    - heal <player>
    - wait 1t
    - if <[type]> != setspectate && <player.is_online>:
        - teleport <player> to:<server.flag[juggernaut_spawn]>
    - if <[type]> != setspectate:
        - flag <player> juggernaut_data:!
    - if <[type]> == setspectate:
        - flag <player> juggernaut_data.ready_spam:<[ready_spam]>
jug_stop_game:
    type: task
    definitions: map|win
    debug: false
    script:
    - if <[win].exists>:
        - foreach <proc[jug_viewers].context[<[map]>]> as:player:
            - define list <list[]>
            - define list:->:<element[<&a>Final<&sp>scores:]>
            - define sidebarlist <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.sort[jug_sort_players]>
            - foreach <[sidebarlist]>:
                - if <[loop_index]> == 1:
                    - define place <element[<proc[jug_gradient].context[1st|#ffaa00/#ffff00|bold]><&sp>]>
                - else if <[loop_index]> == 2:
                    - define place <element[<proc[jug_gradient].context[2nd|#aaaaaa/#dddddd|bold]><&sp>]>
                - else if <[loop_index]> == 3:
                    - define place <element[<proc[jug_gradient].context[3rd|#884400/#aa5500|bold]><&sp>]>
                - else:
                    - define place <element[<proc[jug_gradient].context[<[loop_index]>th|#888888/#aaaaaa]><&sp>]>
                - if <[value]> == <[player]>:
                    - define playercolor <&6><&l>YOU<&sp><&7>
                - else:
                    - define playercolor <&7>
                - define list:->:<element[<[place]><[playercolor]><[value].name>:<&sp><&a><&l><server.flag[juggernaut_maps.<[map]>.game_data.players.<[value]>.score]>].on_hover[<proc[jug_score_history_proc].context[<[map]>|<[value]>].if_null[<&7>N/A]>]>
            - narrate <[list].separated_by[<&nl>]> targets:<[player]>
    - if <server.flag[juggernaut_maps.<[map]>.host_data].exists>:
        - run jug_stop_hosting def:<[map]>
        - stop
    - define phase <server.flag[juggernaut_maps.<[map]>.game_data.phase]>
    - flag server juggernaut_maps.<[map]>.game_data.phase:0
    - run jug_update_sidebar def:<[map]>|off
    - flag server juggernaut_maps.<[map]>.host_data:!
    - if <[phase]> <= 1:
        - foreach <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.if_null[<list>]>:
            - run jug_remove_player def:<[value].flag[juggernaut_data].get[map]>|end_game player:<[value]>
    - else:
        - foreach <proc[jug_viewers].context[<[map]>].if_null[<list>]>:
            - run jug_remove_player def:<[value].flag[juggernaut_data].get[map]>|end_game player:<[value]>
    - flag server juggernaut_maps.<[map]>.game_data:!
    - flag server juggernaut_maps.<[map]>.game_data.phase:0
    - flag server juggernaut_maps.<[map]>.game_data.ready_players:<list[]>
jug_ready_xp:
    type: task
    definitions: map
    debug: false
    script:
    - define players <proc[jug_viewers].context[<[map]>]>
    - foreach <[players]>:
        - if <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size.if_null[0]> > 0:
            - if <server.flag[juggernaut_maps.<[map]>.game_data.countdown].exists>:
                - adjust <[value]> fake_experience:<server.flag[juggernaut_maps.<[map]>.game_data.ready_players].size.div[<server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size.if_null[0]>]>|<server.flag[juggernaut_maps.<[map]>.game_data.countdown]>
            - else:
                - adjust <[value]> fake_experience:<server.flag[juggernaut_maps.<[map]>.game_data.ready_players].size.div[<server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size.if_null[0]>]>|0
        - else:
            - adjust <[value]> fake_experience
    - run jug_update_sidebar def:<[map]>|on
jug_waiting_leave:
    type: item
    material: CLOCK
    display name: <&e>Leave Lobby
    lore:
    - <&7>Right click this item to leave the lobby.
jug_waiting_spectate_item:
    type: item
    material: ENDER_EYE
    display name: <&e>Spectate Match
    lore:
    - <&7>Right click to instead spectate.
jug_waiting_unspectate_item:
    type: item
    material: ENDER_EYE
    display name: <&e>Play Match
    lore:
    - <&7>Right click to instead play.
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
jug_kit_display_item:
    type: item
    material: SLIME_BALL
    display name: <&e>Kits
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
    - if <[page].size> > 0:
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
    debug: false
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
    debug: false
    script:
    - if !<server.has_flag[juggernaut_maps.<[map]>.sidebar_lines]>:
        - execute as_server "sidebar create <&dq>Juggernaut - <[map].to_titlecase><&dq>"
        - flag server juggernaut_maps.<[map]>.sidebar_lines:0
    - if <[mode]> == on:
        - foreach <proc[jug_viewers].context[<[map]>]>:
            - execute as_server "sidebar display <&dq>Juggernaut - <[map].to_titlecase><&dq> player:<[value].name>"
        - run jug_sidebar_display_2 def:<[map]>
    - else:
        - foreach <proc[jug_viewers].context[<[map]>]>:
            - execute as_server "sidebar hide <&dq>Juggernaut - <[map].to_titlecase><&dq> player:<[value].name>"
    - if <[player].exists> && <server.flag[juggernaut_maps.<[map]>.game_data.phase]> >= 2:
        - if <server.flag[juggernaut_maps.<[map]>.game_data.players.<[player]>.score].if_null[0]> >= <server.flag[juggernaut_maps.<[map]>.game_data.victory_condition].if_null[1000]>:
            - title title:<&e><&l><[player].name><&sp><&a>Wins! targets:<proc[jug_viewers].context[<[map]>]>
            - execute as_server "cvstats send pvp_player_result arena:<[map]> game:juggernaut player:<[player].name> team:none result:win"
            - foreach <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.exclude[<[player]>]>:
                - execute as_server "cvstats send pvp_player_result arena:<[map]> game:juggernaut player:<[value].name> team:none result:loss"
            - run jug_stop_game def:<[map]>|true
jug_update_sidebar_lines:
    type: task
    definitions: map|lines
    debug: false
    script:
    - define oldLines <server.flag[juggernaut_maps.<[map]>.sidebar_lines]>
    - if <[lines]> != <[oldLines]>:
        - if <[lines]> > <[oldLines]>:
            - repeat <[lines].sub[<[oldLines]>]>:
                - execute as_server "sidebar addrow <&dq>Juggernaut - <[map].to_titlecase><&dq> LOADING<util.random_uuid>"
        - else:
            - repeat <[oldLines].sub[<[lines]>]>:
                - execute as_server "sidebar removerow <&dq>Juggernaut - <[map].to_titlecase><&dq> <[oldLines].sub[<[value]>]>"
    - flag server juggernaut_maps.<[map]>.sidebar_lines:<[lines]>
jug_sidebar_display_2:
    type: task
    debug: false
    definitions: map
    script:
    - define list <list[]>
    - if <server.flag[juggernaut_maps.<[map]>.game_data.phase].if_null[0]> >= 2:
        - define list:->:<element[&4Juggernaut:<&sp>&c<server.flag[juggernaut_maps.<[map]>.game_data.juggernaut].name>]>
        - define "list:->:&7--------- &c&lGOAL: <server.flag[juggernaut_maps.<[map]>.game_data.victory_condition]> &7---------"
        - define ovrPlayers <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.sort[jug_sort_players]>
        - define sidebarlist <[ovrPlayers].get[1].to[<proc[jug_config_read].context[sidebar_size]>]>
        # Continue from here. Create and remove a sidebar on start/stop of game. Add lines for the players, then replace some with per-player when needed.
        - foreach <[sidebarlist]>:
            - define list:->:<proc[jug_sidebar_player].context[<[map]>|<[value]>|<[loop_index]>|false]>
        - define amount 0
        - ~run jug_update_sidebar_lines def:<[map]>|<[list].size>
        - foreach <[list].reverse>:
            - execute as_server "sidebar setrow <&dq>Juggernaut - <[map].to_titlecase><&dq> <[amount]> <&dq><[value]><&dq>"
            - define amount:+:1
        - define amount 1
        - foreach <[sidebarlist]>:
            - execute as_server "sidebar setrow <&dq>Juggernaut - <[map].to_titlecase><&dq> <[sidebarlist].size.sub[<[amount]>]> <&dq><proc[jug_sidebar_player].context[<[map]>|<[value]>|<[loop_index]>|true]><&dq> player:<[value].name>"
            - define amount:+:1
        - foreach <[ovrPlayers].exclude[<[sidebarlist]>]>:
            - if <proc[jug_config_read].context[sidebar_size]> > 1:
                - execute as_server "sidebar setrow <&dq>Juggernaut - <[map].to_titlecase><&dq> 1 &7... player:<[value].name>"
            - execute as_server "sidebar setrow <&dq>Juggernaut - <[map].to_titlecase><&dq> 0 <&dq><proc[jug_sidebar_player].context[<[map]>|<[value]>|<[ovrPlayers].find[<[value]>]>|true]><&dq> player:<[value].name>"
    - else:
        - define mapBase <server.flag[juggernaut_maps.<[map]>]>
        - if <[mapBase.host_data.host].exists>:
            - define "list:->:&5Host: &d<[mapBase.host_data.host].name>"
        - if <[mapBase.game_data.spectators].size.if_null[0]> >= 1:
            - define add:<&sp>&7(<[mapBase.game_data.spectators].size><&sp>Spectator<proc[jug_plural_s].context[<[mapBase.game_data.spectators].size>]>)
        - if <[mapBase.game_data.players].keys.size.if_null[0]> >= <proc[jug_config_read].context[mininum_players]> || <[mapBase.host_data.host].exists>:
            - define "list:->:&7Players: &f<[mapBase.game_data.players].keys.size.if_null[0]>"
        - else:
            - define "list:->:&7Players: &f<[mapBase.game_data.players].keys.size.if_null[0]>/<proc[jug_config_read].context[mininum_players]><[add].if_null[]>"
        - define add:!
        - if <[mapBase.game_data.countdown].exists>:
            - if <[mapBase.game_data.countdown]> != <[mapBase.game_data.saved_countdown]>:
                - define add:<&sp>&e▷
            - define "list:->:&2Starts In: &a<[mapBase.game_data.countdown]>s<[add].if_null[]>"
            - define add:!
        #- define list:->:<&sp>
        - if <[mapBase.game_data.ready_players].size> >= <[mapBase.game_data.players].keys.size.if_null[0]> && <[mapBase.game_data.players].keys.size.if_null[0]> >= 1:
            - define add:&a&l✓<&sp>
        - define "list:->:<[add].if_null[]>&6Ready: &e<[mapBase.game_data.ready_players].size>/<[mapBase.game_data.players].keys.size.if_null[0]>"
        - if !<[mapBase.host_data.host].exists>:
            - define list:->:<&sp>
            - define "list:->:&cSettings Vote: <proc[jug_custom_settings_top_display].context[<[map]>|short]>"
        - ~run jug_update_sidebar_lines def:<[map]>|<[list].size>
        - foreach <[list].reverse>:
            - execute as_server "sidebar setrow <&dq>Juggernaut - <[map].to_titlecase><&dq> <[loop_index].sub[1]> <&dq><[value]><&dq>"
jug_sidebar_player:
    type: procedure
    debug: false
    definitions: map|player|pos|isPlayer
    script:
    - if <[pos]> == 1:
        - define place "&e&l1st "
    - else if <[pos]> == 2:
        - define place "&f&l2nd "
    - else if <[pos]> == 3:
        - define place "&6&l3rd "
    - else:
        - define place "&7<[pos]>th "
    - if <server.flag[juggernaut_maps.<[map]>.game_data.players.<[player]>.score]> >= <server.flag[juggernaut_maps.<[map]>.game_data.victory_condition].sub[<proc[jug_config_read].context[kill_juggernaut_points|<[map]>]>]> && !<[player].has_flag[juggernaut_data.is_juggernaut]>:
        - define closeextra &e&l⚑<&sp>
    - else if <server.flag[juggernaut_maps.<[map]>.game_data.players.<[player]>.score]> >= <server.flag[juggernaut_maps.<[map]>.game_data.victory_condition].sub[<proc[jug_config_read].context[juggernaut_kill_points|<[map]>]>]> && <[player].has_flag[juggernaut_data.is_juggernaut]>:
        - define closeextra &e&l⚑<&sp>
    - else:
        - define closeextra:!
    - if <[isPlayer]>:
        - define you "&6&lYOU "
    - determine <element[<[closeextra].if_null[]><[place]><[you].if_null[]>&7<[player].name>:<&sp>&a&l<server.flag[juggernaut_maps.<[map]>.game_data.players.<[player]>.score]>]>
jug_sort_players:
    type: procedure
    definitions: player1|player2
    debug: false
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
    - define map <player.flag[juggernaut_data.map].if_null[null]>
    - define pageMin <[size].mul[<player.flag[gui_page].sub[1]>].add[1]>
    - define pageMax <[size].mul[<player.flag[gui_page]>]>
    - define pageList <proc[jug_config_read].context[kits].keys.exclude[<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.banned_kits].if_null[]>].get[<[pageMin]>].to[<[pageMax]>]>
    - foreach <[pageList]>:
        - define page.<[value]>:<proc[jug_config_read].context[kits.<[value]>]>
    - define list <list>
    - foreach <[page]>:
        - define prim <&color[#<[value].get[primary_color]>]>
        - define sec <&color[#<[value].get[secondary_color]>]>
        - define item <[value].get[gui_item].as_item>
        - adjust def:item display_name:<[sec]><&l><&k>;<[prim]><&l><&k>;<[sec]><&l><&k>;<&sp><[prim]><[value].get[display_name]><&sp><[sec]><&l><&k>;<[prim]><&l><&k>;<[sec]><&l><&k>;
        - adjust def:item flag:kit:<[key]>
        - adjust def:item lore:<&7><[value.description].split_lines_by_width[250].replace[<&nl>].with[<&nl><&7>]>
        - adjust def:item hides:all
        - if <[item].flag[kit].if_null[null]> == <player.flag[juggernaut_data.kit].if_null[null]>:
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
    - if <proc[jug_config_read].context[kits].keys.get[<[pageMax].add[1]>].exists>:
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
    b: jug_exit_menu_item[flag=menu:jug_kit_selection_gui;display_name=<&7><&lt><&sp>Back<&sp>To<&sp>Kits]
  procedural items:
    - define list <list>
    - define kit_root <proc[jug_config_read].context[kits].get[<player.flag[juggernaut_data.preview_kit]>]>
    - define item <proc[jug_kit_armor_proc].context[<[kit_root.armor]>|chestplate]>[lore=<proc[jug_item_description].context[<player.flag[juggernaut_data.preview_kit]>|armor]>;hides=ALL;unbreakable=true]
    - define list:->:<[item]>
    - repeat 37:
        - if <[value]> == 37:
            - define value 41
        - if <[kit_root.inventory.<[value]>].exists>:
            - define item_root <[kit_root.inventory.<[value]>]>
            - define item <[item_root].get[type].as_item>
            - adjust def:item lore:<proc[jug_item_description].context[<player.flag[juggernaut_data.preview_kit]>|<[value]>]>
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
        on player clicks item_flagged:kit in jug_kit_selection_gui:
        - define map <player.flag[juggernaut_data.map].if_null[null]>
        - if ( <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.random_only].exists> || <server.flag[juggernaut_maps.<[map]>.host_data.host].flag[juggernaut_custom_settings.random_only].exists> ) && <context.item.flag[kit]> != random:
            - if <context.click> == RIGHT:
                - flag <player> juggernaut_data.preview_kit:<context.item.flag[kit]>
                - inventory open d:jug_kit_preview_gui
                - stop
            - else:
                - narrate "<&c>Sorry, but you may only select random kit due to the host's settings!"
                - stop
        - if <context.item.flag[kit]> != random:
            - if <context.click> == LEFT && <player.has_flag[juggernaut_data.in_game]>:
                - flag <player> juggernaut_data.kit:<context.item.flag[kit]>
                - flag <player> juggernaut_data.kit_selection:!
                - inventory set d:<player.inventory> o:<proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.gui_item]>[display_name=<&7>Selected<&sp>Kit:<&sp><&color[#<proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.primary_color]>]><&l><proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.display_name]>] slot:5
                - if <player.has_flag[juggernaut_data.dead]>:
                    - if !<player.has_flag[juggernaut_data.dead_countdown]>:
                        - run jug_respawn_script player:<player>
                - inventory close o:<player.inventory>
            - else if <context.click> == RIGHT:
                - flag <player> juggernaut_data.preview_kit:<context.item.flag[kit]>
                - inventory open d:jug_kit_preview_gui
        - else if <player.has_flag[juggernaut_data.in_game]>:
            - flag <player> juggernaut_data.kit:!
            - flag <player> juggernaut_data.kit_selection:!
            - inventory set d:<player.inventory> o:FIREWORK_STAR[display_name=<&7>Selected<&sp>Kit:<&sp><&l>Random] slot:5
            - if <player.has_flag[juggernaut_data.dead]>:
                - if !<player.has_flag[juggernaut_data.dead_countdown]>:
                    - run jug_respawn_script player:<player>
            - inventory close o:<player.inventory>
        on player clicks item_flagged:menu in jug_*:
        - if <context.item.has_flag[page]>:
            - flag <player> gui_page:+:<context.item.flag[page]>
        - inventory open d:<context.item.flag[menu]>
        after player flagged:juggernaut_data.kit_selection closes jug_kit_selection_gui:
        - wait 1t
        - if <player.open_inventory> == <player.inventory>:
            - inventory open d:JUG_KIT_SELECTION_GUI
        after player flagged:juggernaut_data.kit_selection closes jug_kit_preview_gui:
        - wait 1t
        - if <player.open_inventory> == <player.inventory>:
            - inventory open d:JUG_KIT_PREVIEW_GUI
jug_give_kit:
    type: task
    debug: false
    script:
    - define map <player.flag[juggernaut_data.map]>
    - if !<player.has_flag[juggernaut_data.kit]>:
        - flag <player> juggernaut_data.kit:<proc[jug_config_read].context[kits].keys.exclude[<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.banned_kits].if_null[]>].random>
    - define kit_root <proc[jug_config_read].context[kits].get[<player.flag[juggernaut_data.kit]>]>
    - inventory clear d:<player.inventory>
    - if !<player.has_flag[juggernaut_data.is_juggernaut]>:
        - inventory set d:<player.inventory> o:player_head[skull_skin=e2859b82-edf0-4893-b358-fb44074d40fd|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvOGMyNGE2MTZkZmZhZTg2MmNmYjllYTczMzlkODlmMjA0MDliOWE4ZTM4NTEzODU2YmIxNDE0MjAxNmZmMTZjZSJ9fX0] slot:40
    - else:
        - inventory set d:<player.inventory> o:player_head[skull_skin=69a4ed90-c7d1-4236-9f39-b8fb6e599c70|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTU5NTNkNjMxMjlmNTIwNWJjZGE5NmM5MWMwNzBjYjFkMzlkMTU1NWQ1ZGZjNDM4MThkNzM3ODg3YzNkMSJ9fX0] slot:40
        - if !<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.glowing_disabled].is_truthy>:
            - cast glowing duration:10000s <player> no_icon hide_particles
        - run jug_juggernaut_slowness def:<[map]>
    - inventory set d:<player.inventory> o:<proc[jug_kit_armor_proc].context[<[kit_root.armor]>|boots]>[attribute_modifiers=<map.with[GENERIC_armor].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[0].with[slot].as[FEET]>]>]>;hides=ALL;unbreakable=true] slot:37
    - inventory set d:<player.inventory> o:leather_leggings[color=#<[kit_root].get[secondary_color]>;attribute_modifiers=<map.with[GENERIC_armor].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[0].with[slot].as[LEGS]>]>]>;hides=ALL;unbreakable=true] slot:38
    - inventory set d:<player.inventory> o:leather_chestplate[color=#<[kit_root].get[primary_color]>;attribute_modifiers=<map.with[GENERIC_armor].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[<[kit_root.armor]>].with[slot].as[CHEST]>]>].with[GENERIC_ARMOR_TOUGHNESS].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[<[kit_root.armor_toughness]>].with[slot].as[CHEST]>]>].with[GENERIC_KNOCKBACK_RESISTANCE].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[0].with[slot].as[CHEST]>]>].with[GENERIC_MOVEMENT_SPEED].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[<[kit_root.speed].sub[0.1]>].with[slot].as[CHEST]>]>]>;hides=ALL;unbreakable=true;lore=<proc[jug_item_description].context[<player.flag[juggernaut_data.kit]>|armor]>] slot:39
    - foreach <[kit_root].get[inventory]>:
        - define item <[value].get[type].as_item>
        - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.attack_cooldown_type].if_null[null]> != 1.8:
            - adjust def:item attribute_modifiers:<map.with[GENERIC_ATTACK_DAMAGE].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[<[value.attack_damage].sub[1].if_null[0]>].with[slot].as[HAND]>]>].with[GENERIC_ATTACK_SPEED].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[<[value.attack_speed].sub[4].if_null[0]>].with[slot].as[HAND]>]>]>
        - else:
            - adjust def:item attribute_modifiers:<map.with[GENERIC_ATTACK_DAMAGE].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[<[value.attack_damage].mul[<[value.attack_speed]>].div[2].sub[1].if_null[0]>].with[slot].as[HAND]>]>].with[GENERIC_ATTACK_SPEED].as[<list[<map.with[operation].as[ADD_NUMBER].with[amount].as[1000].with[slot].as[HAND]>]>]>
        - adjust def:item flag:kit_item:<[key]>
        - if <[value.projectile_damage].exists>:
            - adjust def:item flag:projectile_damage:<[value.projectile_damage]>
        - if <[value.magic_damage].exists>:
            - adjust def:item flag:magic_damage:<[value.magic_damage]>
        - if <[value.magic_range].exists>:
            - adjust def:item flag:magic_range:<[value.magic_range]>
        - if <[value.magic_speed].exists>:
            - adjust def:item flag:magic_speed:<[value.magic_speed]>
        - if <[value.magic_particle].exists>:
            - adjust def:item flag:magic_particle:<[value.magic_particle]>
        - adjust def:item hides:all
        - if !<[value.durability].exists>:
            - adjust def:item unbreakable:true
        - else:
            - adjust def:item durability:<[item].max_durability.sub[<[value.durability]>]>
        - adjust def:item lore:<proc[jug_item_description].context[<player.flag[juggernaut_data.kit]>|<[key]>]>
        - inventory set d:<player.inventory> o:<[item]> slot:<[key]>
    - run JUG_KIT_DISPLAY def:create
    - execute as_server "cvstats send spawned_kit arena:<[map]> game:juggernaut kit:<player.flag[juggernaut_data.kit]> player:<player.name>"
    - if !<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.compass_disabled].is_truthy>:
        - give compass[display_name=<&c>Juggernaut<&sp>Tracker]
jug_abilities:
    type: world
    debug: false
    events:
        on player flagged:juggernaut_data.in_game clicks block with:item_flagged:kit_item:
        - if <proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.inventory.<context.item.flag[kit_item]>.ability].if_null[null]> == null:
            - stop
        - define ability <proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.inventory.<context.item.flag[kit_item]>.ability]>
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
        - define map <player.flag[juggernaut_data.map]>
        - define life_id:<player.flag[juggernaut_data.life_id].if_null[0]>
        - if <player.has_flag[juggernaut_data.tank_charge]> && <[ability.type]> == tank:
            - flag <player> juggernaut_data.stop_tank_charge:true
        - if !<player.has_flag[juggernaut_data.ability_cooldowns.<context.item.flag[kit_item]>]> && <[ability.cooldown].exists>:
            - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.abilities_disabled].is_truthy>:
                - narrate "<&c>Sorry, due to the host's settings abilities are disabled!"
                - stop
            - if <context.item.has_flag[ability_charge]>:
                - narrate "<&c>You already have this ability applied!"
                - stop
            - inventory adjust slot:<player.held_item_slot> flag:last_used:<util.time_now>
            - run jug_ability_actionbar def:<context.item.flag[kit_item]>|<util.time_now>|<[ability]>|<[player_type]>|
            - choose <[ability.type]>:
                - case tank:
                    - define enchant_armor true
                    - definemap attributes:
                        generic_movement_speed:
                            1:
                                operation: ADD_NUMBER
                                amount: -100
                                id: <util.random.uuid>
                        generic_knockback_resistance:
                            1:
                                operation: ADD_NUMBER
                                amount: 1
                                id: <util.random.uuid>
                    - inventory adjust d:<player> slot:37 add_attribute_modifiers:<[attributes]>
                    - inventory adjust slot:39 enchantments:luck=1
                    - run jug_particle_bubble def:tank_on|1.2|outward
                    - repeat <[ability.max_charge_time.<[player_type]>].if_null[<[ability.max_charge_time]>].mul[20]>:
                        - if <player.flag[juggernaut_data.life_id].if_null[0]> == <[life_id]>:
                            - if <player.flag[juggernaut_data.stop_tank_charge].exists>:
                                - goto start_run
                                - repeat stop
                            - flag <player> juggernaut_data.tank_charge:+:1
                            - adjust <player> fake_experience:<player.flag[juggernaut_data.tank_charge].div[<[ability.max_charge_time.<[player_type]>].if_null[<[ability.max_charge_time]>].mul[20].round>]>|0
                            - wait 1t
                        - else:
                            - adjust <player> fake_experience
                            - flag <player> juggernaut_data.tank_charge:!
                            - stop
                    - mark start_run
                    - adjust <player> fake_experience
                    - define vector <player.location.direction.vector.mul[<[ability.velocity.<[player_type]>].if_null[<[ability.velocity]>]>]>
                    - repeat <[ability.max_duration.<[player_type]>].if_null[<[ability.max_duration]>].mul[20].mul[<player.flag[juggernaut_data.tank_charge].div[<[ability.max_charge_time.<[player_type]>].if_null[<[ability.max_charge_time]>].mul[20].round>]>]>:
                        - if <player.flag[juggernaut_data.life_id].if_null[0]> == <[life_id]>:
                            - adjust <player> velocity:<[vector].with_y[<player.velocity.y>]>
                            - hurt <[ability.damage.<[player_type]>].if_null[<[ability.damage]>]> <player.eye_location.find_entities[player].within[2].exclude[<player>]> source:<player> cause:ENTITY_ATTACK
                            - wait 1t
                        - else:
                            - flag <player> juggernaut_data.stop_tank_charge:!
                            - flag <player> juggernaut_data.tank_charge:!
                            - stop
                    - flag <player> juggernaut_data.tank_charge:!
                    - flag <player> juggernaut_data.stop_tank_charge:!
                    - if <player.flag[juggernaut_data.life_id].if_null[0]> == <[life_id]>:
                        - adjust <player> velocity:<[vector].with_y[0].with_x[0].with_z[0]>
                        - inventory adjust d:<player> slot:37 remove_attribute_modifiers:<list[<[attributes.generic_movement_speed.1.id]>|<[attributes.generic_knockback_resistance.1.id]>]>
                        - inventory adjust slot:39 remove_enchantments:<list[].include[luck]>
                        - run jug_particle_bubble def:tank_off|1.2|inward
                - case berserker:
                    - definemap attributes:
                        generic_attack_damage:
                            1:
                                operation: ADD_NUMBER
                                amount: <[ability.bonus_damage.<[player_type]>].if_null[<[ability.bonus_damage]>]>
                                id: <util.random.uuid>
                    - inventory adjust slot:37 add_attribute_modifiers:<[attributes]>
                    - inventory adjust slot:39 enchantments:luck=1
                    - run jug_particle_bubble def:berserker_on|1.2|outward
                    - wait <[ability.duration.<[player_type]>].if_null[<[ability.duration]>]>s
                    - if <player.flag[juggernaut_data.life_id].if_null[0]> == <[life_id]>:
                        - inventory adjust slot:37 remove_attribute_modifiers:<list[<[attributes.generic_attack_damage.1.id]>]>
                        - inventory adjust slot:39 remove_enchantments:<list[].include[luck]>
                        - run jug_particle_bubble def:berserker_off|1.2|inward
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
                    - run jug_healer_particles def:<[ability]>
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
                    - definemap attributes:
                        generic_attack_damage:
                            1:
                                operation: ADD_NUMBER
                                amount: <[ability.damage_reduction.<[player_type]>].if_null[<[ability.damage_reduction]>].mul[-1]>
                                id: <util.random.uuid>
                        generic_movement_speed:
                            1:
                                operation: ADD_NUMBER
                                amount: <[ability.speed_reduction.<[player_type]>].if_null[<[ability.speed_reduction]>].mul[-1]>
                                id: <util.random.uuid>
                    - inventory adjust slot:37 add_attribute_modifiers:<[attributes]>
                    - cast invisibility duration:<[ability.duration.<[player_type]>].if_null[<[ability.duration]>]>
                    - run JUG_KIT_DISPLAY def:remove
                    - playeffect at:<player.location.add[0,0.5,0]> effect:SMOKE_LARGE quantity:500 visibility:200
                    - run jug_ninja_ability def:<[ability.duration.<[player_type]>].if_null[<[ability.duration]>]>|<[attributes]>
                - case demolitionist:
                    - definemap attributes:
                        generic_movement_speed:
                            1:
                                operation: ADD_NUMBER
                                amount: -100
                                id: <util.random.uuid>
                    - inventory adjust d:<player> slot:37 add_attribute_modifiers:<[attributes]>
                    - run jug_give_nojump def:<[ability.countdown.<[player_type]>].if_null[<[ability.countdown]>]>
                    - repeat 3:
                        - if <[life_id]> == <player.flag[juggernaut_data.life_id].if_null[0]>:
                            - playeffect effect:smoke at:<player.location> quantity:<[value].mul[100]> offset:0.5,1,0.5 visibility:200
                            - wait <[ability.countdown.<[player_type]>].if_null[<[ability.countdown]>].div[3]>s
                    - if <[life_id]> == <player.flag[juggernaut_data.life_id].if_null[0]>:
                        - inventory adjust d:<player> slot:37 remove_attribute_modifiers:<list[<[attributes.generic_movement_speed.1.id]>]>
                        - define y <player.eye_location.backward.sub[<player.location>].y.mul[<[ability.launch_velocity.<[player_type]>].if_null[<[ability.launch_velocity]>]>].div[20]>
                        - explode power:<[ability.explosion_radius.<[player_type]>].if_null[<[ability.explosion_radius]>]> <player.eye_location.forward> source:<player>
                        - adjust <player> velocity:<player.location.backward.sub[<player.location>].with_y[<[y]>].mul[<[ability.launch_velocity.<[player_type]>].if_null[<[ability.launch_velocity]>]>]>
                - case trapper:
                    - spawn snowball <player.eye_location.forward> save:trap_snowball
                    - flag <entry[trap_snowball].spawned_entity> jug_trap_snowball:true
                    - flag <entry[trap_snowball].spawned_entity> abilities:<[ability]>
                    - adjust <entry[trap_snowball].spawned_entity> velocity:<player.location.direction.vector.mul[<[ability.throw_velocity.<[player_type]>].if_null[<[ability.throw_velocity]>]>]>
                    - adjust <entry[trap_snowball].spawned_entity> shooter:<player>
                - case adventurer:
                    - run jug_grappling_hook def:<[player_type]>|<[ability]>|<context.item.flag[kit_item]> player:<player>
                - case samurai:
                    - definemap attributes:
                        generic_movement_speed:
                            1:
                                operation: ADD_NUMBER
                                amount: -100
                                id: <util.random.uuid>
                    - definemap reflect_damage:
                        damage_multiplier: <[ability.damage_multiplier.<[player_type]>].if_null[<[ability.damage_multiplier]>]>
                        knockback: <[ability.knockback.<[player_type]>].if_null[<[ability.knockback]>]>
                    - inventory adjust d:<player> slot:37 add_attribute_modifiers:<[attributes]>
                    - inventory adjust slot:39 enchantments:luck=1
                    - run jug_give_nojump def:<[ability.duration.<[player_type]>].if_null[<[ability.duration]>]>
                    - run jug_particle_bubble def:samurai_on|1.2|outward
                    - flag <player> juggernaut_data.reflect_damage:<[reflect_damage]>
                    - adjust <player> velocity:0,-1,0
                    - wait <[ability.duration.<[player_type]>].if_null[<[ability.duration]>]>s
                    - if <player.flag[juggernaut_data.life_id].if_null[0]> == <[life_id]>:
                        - inventory adjust d:<player> slot:37 remove_attribute_modifiers:<list[<[attributes.generic_movement_speed.1.id]>]>
                        - inventory adjust slot:39 remove_enchantments:<list[].include[luck]>
                        - run jug_particle_bubble def:samurai_off|1.2|inward
                        - flag <player> juggernaut_data.reflect_damage:!
        - else if <[ability.mana_cost].exists> && <player.flag[juggernaut_data.mana]> >= <[ability.mana_cost]>:
            - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.abilities_disabled].is_truthy>:
                - narrate "<&c>Sorry, due to the host's settings abilities are disabled!"
                - stop
            - run jug_mana_use def:<[ability.mana_cost]> player:<player>
            - ratelimit <player> 1s
            - choose <[ability.type]>:
                - case mage:
                    - definemap attributes:
                        generic_movement_speed:
                            1:
                                operation: ADD_NUMBER
                                amount: -100
                                id: <util.random.uuid>
                    - inventory adjust d:<player> slot:37 add_attribute_modifiers:<[attributes]>
                    - run jug_give_nojump def:<[ability.countdown.<[player_type]>].if_null[<[ability.countdown]>]>
                    - repeat 3:
                        - if <[life_id]> == <player.flag[juggernaut_data.life_id].if_null[0]>:
                            - run jug_particle_bubble def:mage|<[value].sub[1].div[8].add[1.2]>|outward
                            #- playeffect effect:smoke at:<player.location> quantity:<[value].mul[100]> offset:0.5,1,0.5
                            - wait <[ability.countdown.<[player_type]>].if_null[<[ability.countdown]>].div[3]>s
                    - if <[life_id]> == <player.flag[juggernaut_data.life_id].if_null[0]>:
                        - spawn fireball <player.eye_location.forward> save:mage_fireball
                        - flag <entry[mage_fireball].spawned_entity> no_explosion:true
                        - adjust <entry[mage_fireball].spawned_entity> explosion_fire:false
                        - adjust <entry[mage_fireball].spawned_entity> explosion_radius:<[ability.fireball_radius.<[player_type]>].if_null[<[ability.fireball_radius]>]>
                        - adjust <entry[mage_fireball].spawned_entity> velocity:<player.location.direction.vector.mul[<[ability.fireball_speed.<[player_type]>].if_null[<[ability.fireball_speed]>]>]>
                        - adjust <entry[mage_fireball].spawned_entity> shooter:<player>
                        - inventory adjust d:<player> slot:37 remove_attribute_modifiers:<list[<[attributes.generic_movement_speed.1.id]>]>
                        - define map <player.flag[juggernaut_data.map]>
                        - repeat 15:
                            - wait 1s
                            - if <entry[mage_fireball].spawned_entity.is_spawned>:
                                - if !<entry[mage_fireball].spawned_entity.location.is_in[jug_<[map]>]>:
                                    - remove <entry[mage_fireball].spawned_entity>
                            - else:
                                - stop
                        - if <entry[mage_fireball].spawned_entity.is_spawned>:
                            - remove <entry[mage_fireball].spawned_entity>
                - case frostmancer:
                    - define life_id:<player.flag[juggernaut_data.life_id].if_null[0]>
                    - repeat <[ability.snowball_amount.<[player_type]>].if_null[<[ability.snowball_amount]>]>:
                        - if <player.flag[juggernaut_data.life_id].if_null[0]> == <[life_id]>:
                            - spawn snowball <player.eye_location.forward> save:frostmancer_snowball
                            - flag <entry[frostmancer_snowball].spawned_entity> snowball_slow:<[ability.snowball_slow.<[player_type]>].if_null[<[ability.snowball_slow]>]>
                            - flag <entry[frostmancer_snowball].spawned_entity> snowball_slow_duration:<[ability.snowball_slow_duration.<[player_type]>].if_null[<[ability.snowball_slow_duration]>]>
                            - flag <entry[frostmancer_snowball].spawned_entity> snowball_knockback:<[ability.snowball_knockback.<[player_type]>].if_null[<[ability.snowball_knockback]>]>
                            - flag <entry[frostmancer_snowball].spawned_entity> snowball_damage_bonus:<[ability.snowball_damage_bonus.<[player_type]>].if_null[<[ability.snowball_damage_bonus]>]>
                            - adjust <entry[frostmancer_snowball].spawned_entity> velocity:<player.location.direction.vector.mul[<[ability.snowball_speed.<[player_type]>].if_null[<[ability.snowball_speed]>]>]>
                            - adjust <entry[frostmancer_snowball].spawned_entity> shooter:<player>
                            - wait 0.2s
        - else if <[ability.cooldown].exists>:
            - narrate "<&c>Your ability is still on cooldown for <&l><player.flag[juggernaut_data.ability_cooldowns.<context.item.flag[kit_item]>]>s<&c>!"
        - else if <[ability.mana_cost].exists>:
            - narrate "<&c>You don't have enough mana for that!"
        on player flagged:juggernaut_data.in_game toggles item_flagged:kit_item:
        - if <context.state>:
            - if <player.item_in_hand.advanced_matches[shield]>:
                - define slot <player.held_item_slot>
                - define item <player.item_in_hand>
                - define ability <proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.inventory.<player.item_in_hand.flag[kit_item]>.ability]>
            - else if <player.item_in_offhand.advanced_matches[shield]>:
                - define slot 41
                - define item <player.item_in_offhand>
                - define ability <proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.inventory.<player.item_in_offhand.flag[kit_item]>.ability]>
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
            - define map <player.flag[juggernaut_data.map]>
            - if !<player.has_flag[juggernaut_data.ability_cooldowns.<[item].flag[kit_item]>]>:
                - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.abilities_disabled].is_truthy>:
                    - narrate "<&c>Sorry, due to the host's settings abilities are disabled!"
                    - stop
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
                - narrate "<&c>Your ability is still on cooldown for <&l><player.flag[juggernaut_data.ability_cooldowns.<[item].flag[kit_item]>]>s<&c>!"
        - else:
            - if <player.item_in_hand.advanced_matches[shield]>:
                - define slot <player.held_item_slot>
            - else if <player.item_in_offhand.advanced_matches[shield]>:
                - define slot 41
            - else:
                - stop
            - inventory adjust slot:<[slot]> flag:ability_active:!
        on player flagged:juggernaut_data.in_game breaks held shield:
            - define item <context.item>
            - define slot <context.slot>
            - adjust def:item durability:<[item].max_durability.sub[<proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.inventory.<[item].flag[kit_item]>.durability]>]>
            - wait 1t
            - inventory set d:<player.inventory> o:air slot:<[slot]>
            - animate <player> STOP_USE_ITEM
            - wait 1t
            - itemcooldown <[item].material> d:<proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.inventory.<[item].flag[kit_item]>.durability_cooldown]>s
            - inventory set d:<player.inventory> o:<[item]> slot:<[slot]>
            # If this ever starts activating the ability while the player was sneaking when the cooldown ends (but without the player touching the shield), remove everything from here to the next comment
            - wait <proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.inventory.<[item].flag[kit_item]>.durability_cooldown]>s
            - animate <player> START_USE_OFFHAND_ITEM
            - wait 1t
            - animate <player> STOP_USE_ITEM
            # Stop removing here.
jug_ninja_ability:
    type: task
    definitions: duration|attributes
    debug: false
    script:
        - cast remove glowing
        - define life_id <player.flag[juggernaut_data.life_id].if_null[0]>
        - define map <player.flag[juggernaut_data.map]>
        - flag <player> juggernaut_data.invis:true
        - fakeequip <player> for:<server.flag[juggernaut_maps.<player.flag[juggernaut_data.map]>.game_data.players].keys.exclude[<player>]> duration:<[duration]>s hand:air head:air chest:air legs:air boots:air
        - adjust <player> clear_body_arrows
        - repeat <[duration].mul[5]>:
            - if <player.flag[juggernaut_data.life_id].if_null[0]> == <[life_id]>:
                - if <player.is_sprinting>:
                    - playeffect effect:BLOCK_DUST at:<player.location> quantity:7 special_data:black_wool velocity:<location[0,-1,0]> visibility:200
                - wait 0.2s
        - if <player.has_flag[juggernaut_data.in_game]>:
            - flag <player> juggernaut_data.invis:!
        - if <player.has_flag[juggernaut_data.is_juggernaut]> && !<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.glowing_disabled].is_truthy> && <player.flag[juggernaut_data.life_id].if_null[0]> == <[life_id]>:
            - cast glowing duration:10000s <player> no_icon hide_particles
        - if <player.flag[juggernaut_data.life_id].if_null[0]> == <[life_id]>:
            - inventory adjust slot:37 remove_attribute_modifiers:<list[<[attributes.generic_attack_damage.1.id]>|<[attributes.generic_movement_speed.1.id]>]>
            - playeffect at:<player.location.add[0,0.5,0]> effect:SMOKE quantity:500 data:0.1 visibility:200
            - run JUG_KIT_DISPLAY def:create
jug_ability_actionbar:
    type: task
    debug: false
    definitions: item|use_time|ability|player_type|display_name
    script:
    - if !<[ability].exists>:
        - narrate "<&c>ERROR CODE 70: Invalid Ability."
        - stop
    - define map <player.flag[juggernaut_data.map]>
    - define cooldown_time <proc[jug_ability_cooldown_proc].context[<[player_type]>|<[map]>|<[ability]>]>
    - define cooldown_left 0
    - define life_id:<player.flag[juggernaut_data.life_id].if_null[0]>
    - if <[ability.click_type]> == right:
        - define type_display <element[Right<&sp>Click]>
    - else if <[ability.click_type]> == left:
        - define type_display <element[Left<&sp>Click]>
    - else if <[ability.click_type]> == shift_shield:
        - define type_display <element[Shift<&sp>Shield]>
    - define uuid <util.random_uuid>
    - flag <player> juggernaut_data.ability_cooldowns.<[item]>:<[cooldown_time].sub[<[cooldown_left]>]>
    - bossbar create <[uuid]> players:<player> "title:<&d><[ability.display_name]> <&5>(<[type_display]>)" color:pink style:solid progress:0
    - while <[cooldown_left]> < <[cooldown_time]>:
        - wait 0.1s
        - if !<player.has_flag[juggernaut_data.dead]> && <player.has_flag[juggernaut_data.in_game]> && <player.flag[juggernaut_data.life_id].if_null[0]> == <[life_id]>:
                - define cooldown_left:+:0.1
                - if <player.has_flag[juggernaut_data.ability_cooldown_reductions.<[item]>]>:
                    - define bonus_time <[cooldown_time].mul[<player.flag[juggernaut_data.ability_cooldown_reductions.<[item]>]>]>
                    - flag <player> juggernaut_data.ability_cooldown_reductions.<[item]>:!
                    - define cooldown_left:+:<[bonus_time]>
                - define bars <[cooldown_left].div[<[cooldown_time]>].if_null[0]>
                - bossbar update <[uuid]> "title:<&d><[ability.display_name]> <&5>(<[type_display]>) <&a><&l><[cooldown_time].sub[<[cooldown_left]>]>s" progress:<[bars]>
                - flag <player> juggernaut_data.ability_cooldowns.<[item]>:<[cooldown_time].sub[<[cooldown_left]>]>
        - else:
            - if <player.has_flag[juggernaut_data.in_game]>:
                - flag <player> juggernaut_data.ability_cooldowns.<[item]>:!
            - bossbar remove <[uuid]>
            - stop
    - bossbar update <[uuid]> "title:<&d><[ability.display_name]> <&5>(<[type_display]>) <&a><&l>Ready!" progress:1
    - flag <player> juggernaut_data.ability_cooldowns.<[item]>:!
    - narrate "<&d><&l>✦ <&d><[ability.display_name]> <&5>is ready!"
    - wait 2s
    - bossbar remove <[uuid]>
jug_load_config:
    type: world
    debug: false
    events:
        on server start:
        - yaml load:scripts/Juggernaut/juggernaut.yaml id:juggernaut
        on reload scripts:
        - yaml load:scripts/Juggernaut/juggernaut.yaml id:juggernaut
jug_viewers:
    type: procedure
    definitions: map
    debug: false
    script:
    - define list <list>
    - if <server.flag[juggernaut_maps.<[map]>.game_data.players].exists>:
        - define list:|:<server.flag[juggernaut_maps.<[map]>.game_data.players].keys>
    - if <server.flag[juggernaut_maps.<[map]>.game_data.spectators].exists>:
        - define list:|:<server.flag[juggernaut_maps.<[map]>.game_data.spectators]>
    - determine <[list]>
jug_active_players:
    type: procedure
    definitions: map
    debug: false
    script:
    - determine <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.filter_tag[<[filter_value].has_flag[juggernaut_data.dead].not>].filter_tag[<[filter_value].has_flag[juggernaut_data.spectator].not>]>
jug_map_assignment:
## When assigning, do '/npc assign --set jug_map_assignment'
    type: assignment
    debug: false
    actions:
        on assignment:
        - narrate "NPC assigned to Juggernaut maps"
        - trigger name:click state:true
    interact scripts:
    - jug_map_interact
jug_map_interact:
    type: interact
    debug: false
    steps:
        1:
            click trigger:
                script:
                - flag <player> gui_page:1
                - inventory open d:jug_map_selection_gui
                - while <player.open_inventory.script.name.if_null[null]> == jug_map_selection_gui:
                    - inventory open d:jug_map_selection_gui
                    - wait 3s
jug_settings_assignment:
## When assigning, do '/npc assign --set jug_settings_assignment'
    type: assignment
    debug: false
    actions:
        on assignment:
        - narrate "NPC assigned to Juggernaut settings"
        - trigger name:click state:true
    interact scripts:
    - jug_settings_interact
jug_settings_interact:
    type: interact
    debug: false
    steps:
        1:
            click trigger:
                script:
                - flag <player> gui_page:1
                - inventory open d:jug_hosting_main_inv
jug_tutorial:
    type: task
    definitions: stage
    debug: false
    script:
    - choose <[stage]>:
        - case intro:
            - clickable jug_tutorial def:points usages:1 save:next
            - clickable jug_tutorial def:none usages:1 save:prev
            - narrate "<&c><&l>-/-/-/- <&e>Introduction to Juggernaut <&c><&l>-\-\-\-<&nl><&7>Welcome to Juggernaut! Juggernaut is sort of like a reverse tag in Minecraft, with one player being it (the juggernaut), and everyone else trying to kill them to become the juggernaut. If you want more information, I would recommend clicking the arrows below to look at the next pages!<&nl><&c><&l>-/-/-/- <element[<&e>≪<&sp>Prev].on_click[<entry[prev].command>]> <&c><&l>-/-\- <element[<&e>Next<&sp>≫].on_click[<entry[next].command>]> <&c><&l>-\-\-\-"
        - case points:
            - clickable jug_tutorial def:starting usages:1 save:next
            - clickable jug_tutorial def:intro usages:1 save:prev
            - narrate "<&c><&l>-/-/-/- <&e>Score & Winning <&c><&l>-\-\-\-<&nl><&7>In order to win, you must reach a certain amount of points specified in the sidebar. There are two ways to get points: Either kill the juggernaut (<&a><proc[jug_config_read].context[kill_juggernaut_points].if_null[null]><&7>), or kill a player as the juggernaut (<&a><proc[jug_config_read].context[juggernaut_kill_points].if_null[null]><&7>).<&nl><&c><&l>-/-/-/- <element[<&e>≪<&sp>Prev].on_click[<entry[prev].command>]> <&c><&l>-/-\- <element[<&e>Next<&sp>≫].on_click[<entry[next].command>]> <&c><&l>-\-\-\-"
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
    debug: false
    events:
        on player flagged:juggernaut_data.in_game breaks block:
        - determine passively cancelled
        on player flagged:juggernaut_data.in_game places block:
        - determine passively cancelled
        on player flagged:juggernaut_data.in_game drops item:
        - determine passively cancelled
        on player flagged:juggernaut_data.in_game swaps items:
        - determine passively cancelled
        on block destroyed by explosion:
        - if <context.source_entity.has_flag[no_explosion]>:
            - determine passively cancelled
        on entity breaks hanging:
        - if <context.breaker.has_flag[no_explosion]>:
            - determine passively cancelled
        - if <context.breaker.has_flag[juggernaut_data.in_game]>:
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
    debug: false
    script:
    - if !<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.resistances.base].exists>:
        - define minPlayers <proc[jug_config_read].context[juggernaut_settings.resistances.min_players]>
        - define perPlayer <proc[jug_config_read].context[juggernaut_settings.resistances.base.per_player]>
        - define maxRes <proc[jug_config_read].context[juggernaut_settings.resistances.base.max_res]>
        - define players <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size.if_null[0]>
        - define baseResistance <element[1].sub[<[players].add[1].sub[<[minPlayers]>].mul[<[perPlayer]>].min[<[maxRes]>]>]>
        - if <[players]> < <[minPlayers]>:
            - define baseResistance 1
    - else:
        - define baseResistance <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.resistances.base]>
    - define bonusResistance 1
    - if !<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.resistances.<[cause]>].exists> && <proc[jug_config_read].context[juggernaut_settings.resistances.<[cause]>].if_null[null]> != null:
        - define perPlayer <proc[jug_config_read].context[juggernaut_settings.resistances.<[cause]>.per_player]>
        - define maxRes <proc[jug_config_read].context[juggernaut_settings.resistances.<[cause]>.max_res]>
        - define bonusResistance <element[1].sub[<[players].add[1].sub[<[minPlayers]>].mul[<[perPlayer]>].min[<[maxRes]>]>]>
        - if <[players]> < <[minPlayers]>:
            - define bonusResistance 1
    - else if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.resistances.<[cause]>].exists>:
        - define bonusResistance <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.resistances.<[cause]>]>
    - determine <[baseResistance].mul[<[bonusResistance]>]>
jug_config_read:
    type: procedure
    definitions: path|map
    debug: false
    script:
    - define result <yaml[juggernaut].read[<[path]>].if_null[null]>
    - choose <[path]>:
        - case victory_conditions:
            - foreach <yaml[juggernaut].read[<[path]>].keys.sort_by_number[].reverse>:
                    - if <[value]> <= <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size.if_null[0]>:
                        - define result <yaml[juggernaut].read[<[path]>.<[value]>]>
                        - foreach stop
    - if <[map].exists>:
        - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.<[path]>].exists>:
            - define result <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.<[path]>]>
    - determine <[result]>
jug_stop_hosting:
    type: task
    definitions: map
    debug: false
    script:
    - define host <server.flag[juggernaut_maps.<[map]>.host_data.host]>
    - flag <[host]> juggernaut_data.is_host:!
    - flag server juggernaut_maps.<[map]>.host_data:!
    - run jug_stop_game def:<[map]>
    - run jug_remove_player def:<[map]>
jug_hosting_main_inv:
  type: inventory
  inventory: CHEST
  title: Juggernaut Game Settings
  size: 54
  gui: true
  debug: false
  definitions:
    g: black_stained_glass_pane[display_name=<&sp>]
    t: jug_tutorial_item
  procedural items:
    - define map <player.flag[juggernaut_data.map].if_null[]>
    - define list <list>
    - if <player.has_flag[juggernaut_data.is_host]> || !<server.flag[juggernaut_maps.<[map]>].exists>:
        - define item <item[redstone]>
        - adjust def:item flag:juggernaut:reset_all
        - adjust def:item "display_name:<&e><&l>Reset All"
        - define lore <list>
        - adjust def:item "lore:<&7>Resets all settings back to default. <&nl><&e>Control Drop: <&7>Reset"
        - define list:->:<[item]>
    - define item <item[clock]>
    - adjust def:item flag:juggernaut:respawn_timer
    - adjust def:item display_name:<&e><&l>Respawn<&sp>Timer
    - adjust def:item "lore:<&7>Time it takes for players to respawn <&nl><&nl><proc[jug_settings_value_proc].context[host|<[map]>|respawn_timer]>"
    - define list:->:<[item]>
    - define item <item[emerald]>
    - adjust def:item flag:juggernaut:points
    - adjust def:item display_name:<&e><&l>Points<&sp>Earned
    - adjust def:item "lore:<&7>Points earned from various actions <&nl><&nl><player.flag[juggernaut_data.host_data.points].equals[kill_juggernaut_points].if_true[<&a>].if_false[<&7>].if_null[<&a>]>[1] <proc[jug_settings_value_proc].context[host|<[map]>|kill_juggernaut_points]> <&nl><player.flag[juggernaut_data.host_data.points].equals[juggernaut_kill_points].if_true[<&a>].if_false[<&7>].if_null[<&7>]>[2] <proc[jug_settings_value_proc].context[host|<[map]>|juggernaut_kill_points]> <&nl><player.flag[juggernaut_data.host_data.points].equals[jug_scoring_method].if_true[<&a>].if_false[<&7>].if_null[<&7>]>[3] <proc[jug_settings_value_proc].context[host|<[map]>|jug_scoring_method]> <&nl><player.flag[juggernaut_data.host_data.points].equals[jug_interval_time].if_true[<&a>].if_false[<&7>].if_null[<&7>]>[4] <proc[jug_settings_value_proc].context[host|<[map]>|jug_interval_time]>"
    - define list:->:<[item]>
    - define item <item[shield]>
    - adjust def:item flag:juggernaut:spawn_protection
    - adjust def:item display_name:<&e><&l>Spawn<&sp>Protection
    - adjust def:item "lore:<&7>Resistance given when respawning <&nl><&nl><player.flag[juggernaut_data.host_data.spawn_protection].equals[spawn_protection_duration].if_true[<&a>].if_false[<&7>].if_null[<&a>]>[1] <proc[jug_settings_value_proc].context[host|<[map]>|spawn_protection_duration]> <&nl><player.flag[juggernaut_data.host_data.spawn_protection].equals[spawn_protection_level].if_true[<&a>].if_false[<&7>].if_null[<&7>]>[2] <proc[jug_settings_value_proc].context[host|<[map]>|spawn_protection_level]>"
    - define list:->:<[item]>
    - define item <item[gold_ingot]>
    - adjust def:item flag:juggernaut:victory_condition
    - adjust def:item display_name:<&e><&l>Victory<&sp>Condition
    - adjust def:item "lore:<&7>The amount of points required to win <&nl><&nl><proc[jug_settings_value_proc].context[host|<[map]>|victory_conditions]>"
    - define list:->:<[item]>
    - define item <item[diamond_chestplate]>
    - adjust def:item flag:juggernaut:resistances
    - adjust def:item display_name:<&e><&l>Juggernaut<&sp>Resistances
    - adjust def:item "lore:<&7>Damage multipliers to the juggernaut from <&nl><&7>various sources <&nl><&nl><player.flag[juggernaut_data.host_data.resistances].equals[base].if_true[<&a>].if_false[<&7>].if_null[<&a>]>[1] <proc[jug_settings_value_proc].context[host|<[map]>|juggernaut_base_resistance]> <&nl><player.flag[juggernaut_data.host_data.resistances].equals[projectile].if_true[<&a>].if_false[<&7>].if_null[<&7>]>[2] <proc[jug_settings_value_proc].context[host|<[map]>|juggernaut_projectile_resistance]> <&nl><player.flag[juggernaut_data.host_data.resistances].equals[entity_explosion].if_true[<&a>].if_false[<&7>].if_null[<&7>]>[3] <proc[jug_settings_value_proc].context[host|<[map]>|juggernaut_entity_explosion_resistance]> <&nl><player.flag[juggernaut_data.host_data.resistances].equals[entity_attack].if_true[<&a>].if_false[<&7>].if_null[<&7>]>[4] <proc[jug_settings_value_proc].context[host|<[map]>|juggernaut_entity_attack_resistance]>"
    - define list:->:<[item]>
    - define item <item[slime_ball]>
    - adjust def:item flag:juggernaut:kits
    - adjust def:item display_name:<&e><&l>Kit<&sp>Choices
    - adjust def:item "lore:<&7>Restrict possible kits, or make it random only <&nl><&nl><proc[jug_settings_value_proc].context[host|<[map]>|banned_kits]> <&nl><&7><proc[jug_settings_value_proc].context[host|<[map]>|random_only]>"
    - define list:->:<[item]>
    - define item <item[light_blue_dye]>
    - adjust def:item flag:juggernaut:abilities
    - adjust def:item display_name:<&e><&l>Abilities
    - adjust def:item "lore:<&7>Ability related options. <&nl><&nl><player.flag[juggernaut_data.host_data.abilities].equals[cooldown_multiplier].if_true[<&a>].if_false[<&7>].if_null[<&a>]>[1] <proc[jug_settings_value_proc].context[host|<[map]>|cooldown_multiplier]> <&nl><player.flag[juggernaut_data.host_data.abilities].equals[mana_multiplier].if_true[<&a>].if_false[<&7>].if_null[<&7>]>[2] <proc[jug_settings_value_proc].context[host|<[map]>|mana_multiplier]> <&nl><player.flag[juggernaut_data.host_data.abilities].equals[abilities_disabled].if_true[<&a>].if_false[<&7>].if_null[<&7>]>[3] <proc[jug_settings_value_proc].context[host|<[map]>|abilities_disabled]>"
    - define list:->:<[item]>
    - define item <item[compass]>
    - adjust def:item flag:juggernaut:tracking
    - adjust def:item display_name:<&e><&l>Tracking
    - adjust def:item "lore:<&7>Lets you disable the juggernaut tracker or the glowing. <&nl><&nl><player.flag[juggernaut_data.host_data.tracking].equals[compass_disabled].if_true[<&a>].if_false[<&7>].if_null[<&a>]>[1] <proc[jug_settings_value_proc].context[host|<[map]>|compass_disabled]> <&nl><player.flag[juggernaut_data.host_data.tracking].equals[glowing_disabled].if_true[<&a>].if_false[<&7>].if_null[<&7>]>[2] <proc[jug_settings_value_proc].context[host|<[map]>|glowing_disabled]>"
    - define list:->:<[item]>
    - define item <item[golden_apple]>
    - adjust def:item flag:juggernaut:health
    - adjust def:item display_name:<&e><&l>Healing
    - adjust def:item "lore:<&7>Change max health, or disable natural regeneration. <&nl><&nl><player.flag[juggernaut_data.host_data.health].equals[max_health].if_true[<&a>].if_false[<&7>].if_null[<&a>]>[1] <proc[jug_settings_value_proc].context[host|<[map]>|max_health]> <&nl><player.flag[juggernaut_data.host_data.health].equals[regen_disabled].if_true[<&a>].if_false[<&7>].if_null[<&7>]>[2] <proc[jug_settings_value_proc].context[host|<[map]>|regen_disabled]>"
    - define list:->:<[item]>
    - define item <item[red_bed]>
    - adjust def:item flag:juggernaut:spawning
    - adjust def:item display_name:<&e><&l>Spawning
    - adjust def:item "lore:<&7>Choose when the juggernaut spawn is used. <&nl><&nl><proc[jug_settings_value_proc].context[host|<[map]>|juggernaut_spawning]>"
    - define list:->:<[item]>
    - define item <item[diamond_sword]>
    - adjust def:item flag:juggernaut:pvp
    - adjust def:item display_name:<&e><&l>PVP<&sp>Settings
    - adjust def:item "lore:<&7>Edit settings regarding PVP. <&nl><&nl><player.flag[juggernaut_data.host_data.pvp].equals[attack_cooldown_type].if_true[<&a>].if_false[<&7>].if_null[<&a>]>[1] <proc[jug_settings_value_proc].context[host|<[map]>|attack_cooldown_type]> <&nl><player.flag[juggernaut_data.host_data.pvp].equals[combo_mode].if_true[<&a>].if_false[<&7>].if_null[<&7>]>[2] <proc[jug_settings_value_proc].context[host|<[map]>|combo_mode]>"
    - define list:->:<[item]>
    - if <player.has_flag[juggernaut_data.is_host]>:
        - if <server.flag[juggernaut_maps.<[map]>.game_data.phase]> == 0 && <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size.if_null[0]> >= <proc[jug_config_read].context[mininum_players]>:
            - define item <item[lime_dye]>
            - adjust def:item flag:juggernaut:start_game
            - adjust def:item display_name:<&a><&l>Start<&sp>Game
            - adjust def:item "lore:<&7>Click here to start the game"
            - define list:->:<[item]>
        - else if <server.flag[juggernaut_maps.<[map]>.game_data.phase]> == 0:
            - define item <item[gray_dye]>
            - adjust def:item flag:juggernaut:start_game
            - adjust def:item display_name:<&7><&l>Start<&sp>Game
            - adjust def:item "lore:<&7>Click here to start the game <&nl><&c>Not enough players! Mininum: <&l><proc[jug_config_read].context[mininum_players]>"
            - define list:->:<[item]>
        - else:
            - define item <item[air]>
            - define list:->:<[item]>
    - else:
        - define list:->:black_stained_glass_pane[display_name=<&sp>]
    - if <player.has_flag[juggernaut_data.is_host]> || !<server.flag[juggernaut_maps.<[map]>].exists>:
        - define item <item[repeater]>
        - adjust def:item flag:juggernaut:saves
        - adjust def:item display_name:<&e><&l>Saves
        - define lore <list>
        - define "lore:->:<&e>Left Click: <&7>Load Settings"
        - define "lore:->:<&e>Right Click: <&7>Save Settings<&nl>"
        - repeat 9:
            - define "lore:->:<player.flag[juggernaut_data.host_data.save_slot].equals[<[value]>].if_true[<&a>].if_false[<&7>].if_null[<[value].equals[1].if_true[<&a>].if_false[<&7>]>]>[<[value]>] <&7>Slot <[value]>: <&e><player.flag[juggernaut_settings_saves.<[value]>].exists.if_true[<player.flag[juggernaut_settings_saves.<[value]>.save_name].exists.if_true[<&a><player.flag[juggernaut_settings_saves.<[value]>.save_name].unescaped>].if_false[<&a>Used <&c>(Unnamed!)]>].if_false[<&c>Empty]>"
        - adjust def:item "lore:<&7>Save slots for host settings <&nl><[lore].separated_by[<&nl>]>"
        - define list:->:<[item]>
        - define item <item[oak_sign]>
        - adjust def:item flag:juggernaut:host_info
        - adjust def:item "display_name:<&e><&l>Numerical Settings Keys"
        - adjust def:item "lore:<&e>Left Click: <&7>Increase<&nl><&e>Right Click: <&7>Decrease<&nl><&e>Shift Left Click: <&7>Substantial Increase <&nl><&e>Shift Right Click: <&7>Substantial Decrease <&nl><&e>Drop: <&7>Reset to Default <&nl><&nl><&7>(Left click to view other pages) <&nl><&a>○<&7>○○○"
        - choose <player.flag[juggernaut_data.host_data.host_info].if_null[1]>:
            - case 2:
                - adjust def:item "display_name:<&e><&l>Toggle Settings Keys"
                - adjust def:item "lore:<&e>Left Click/Right Click: <&7>Toggle<&nl><&e>Drop: <&7>Reset to Default <&nl><&nl><&7>(Left click to view other pages) <&nl><&7>○<&a>○<&7>○○"
            - case 3:
                - adjust def:item "display_name:<&e><&l>List Settings Keys"
                - adjust def:item "lore:<&e>Left Click: <&7>Next Option<&nl><&e>Right Click: <&7>Previous Option<&nl><&e>Drop: <&7>Reset to Default <&nl><&nl><&7>(Left click to view other pages) <&nl><&7>○○<&a>○<&7>○"
            - case 4:
                - adjust def:item "display_name:<&e><&l>Items w/ Multiple Settings Keys"
                - adjust def:item "lore:<&e>Number Keys: <&7>Select Associated Setting <&nl><&nl><&7>(Left click to view other pages) <&nl><&7>○○○<&a>○"
        - define list:->:<[item]>
    - else:
        - repeat 2:
            - define list:->:black_stained_glass_pane[display_name=<&sp>]
    - determine <[list]>
  slots:
    - [g] [g] [g] [g] [] [g] [g] [g] [g]
    - [g] [] [] [] [] [] [] [] [g]
    - [g] [] [] [] [] [g] [g] [g] [g]
    - [g] [g] [g] [g] [g] [g] [g] [g] [g]
    - [g] [g] [g] [g] [] [g] [g] [] [g]
    - [] [g] [g] [g] [g] [g] [g] [g] [g]
jug_hosting_click:
    type: world
    debug: false
    events:
        on player clicks item_flagged:juggernaut in jug_hosting_main_inv:
        - define flag <context.item.flag[juggernaut]>
        - define map <player.flag[juggernaut_data.map].if_null[]>
        - if !<player.has_flag[juggernaut_data.is_host]> && <player.has_flag[juggernaut_data.in_game]>:
            - stop
        - choose <[flag]>:
            - case start_game:
                - if <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size.if_null[0]> >= <proc[jug_config_read].context[mininum_players]>:
                    - run jug_start_task def:<[map]>|5
                - else:
                    - narrate "<&c>Not enough players to start!"
            - case respawn_timer:
                - if !<player.flag[juggernaut_custom_settings.respawn_timer].exists>:
                    - flag player juggernaut_custom_settings.respawn_timer:<proc[jug_config_read].context[respawn_timer|<[map]>].round>
                - choose <context.click>:
                    - case left:
                        - flag player juggernaut_custom_settings.respawn_timer:+:1
                    - case right:
                        - flag player juggernaut_custom_settings.respawn_timer:-:1
                    - case shift_left:
                        - flag player juggernaut_custom_settings.respawn_timer:+:5
                    - case shift_right:
                        - flag player juggernaut_custom_settings.respawn_timer:-:5
                    - case drop:
                        - flag player juggernaut_custom_settings.respawn_timer:!
                - if <player.flag[juggernaut_custom_settings.respawn_timer].exists>:
                    - if <player.flag[juggernaut_custom_settings.respawn_timer]> < 0:
                        - flag player juggernaut_custom_settings.respawn_timer:0
                    - if <player.flag[juggernaut_custom_settings.respawn_timer]> > 300:
                        - flag player juggernaut_custom_settings.respawn_timer:300
            - case points:
                - if !<player.flag[juggernaut_data.host_data.points].exists>:
                    - flag <player> juggernaut_data.host_data.points:kill_juggernaut_points
                - define point_type:<player.flag[juggernaut_data.host_data.points]>
                - if !<player.flag[juggernaut_custom_settings.<[point_type]>].exists> && <context.click> != number_key:
                    - choose <[point_type]>:
                        - case kill_juggernaut_points || juggernaut_kill_points:
                            - flag player juggernaut_custom_settings.<[point_type]>:<proc[jug_config_read].context[<[point_type]>|<[map]>].round>
                        - case jug_scoring_method:
                            - flag player juggernaut_custom_settings.<[point_type]>:kill
                        - case jug_interval_time:
                            - flag player juggernaut_custom_settings.<[point_type]>:30
                - if <[point_type]> != jug_scoring_method:
                    - choose <context.click>:
                        - case left:
                            - flag player juggernaut_custom_settings.<[point_type]>:+:1
                        - case right:
                            - flag player juggernaut_custom_settings.<[point_type]>:-:1
                        - case shift_left:
                            - if <[point_type]> == jug_interval_time:
                                - flag player juggernaut_custom_settings.<[point_type]>:+:10
                            - else:
                                - flag player juggernaut_custom_settings.<[point_type]>:+:5
                        - case shift_right:
                            - if <[point_type]> == jug_interval_time:
                                - flag player juggernaut_custom_settings.<[point_type]>:-:10
                            - else:
                                - flag player juggernaut_custom_settings.<[point_type]>:-:5
                        - case drop:
                            - flag player juggernaut_custom_settings.<[point_type]>:!
                        - case number_key:
                            - choose <context.hotbar_button>:
                                - case 1:
                                    - flag <player> juggernaut_data.host_data.points:kill_juggernaut_points
                                - case 2:
                                    - flag <player> juggernaut_data.host_data.points:juggernaut_kill_points
                                - case 3:
                                    - flag <player> juggernaut_data.host_data.points:jug_scoring_method
                                - case 4:
                                    - if <player.flag[juggernaut_custom_settings.jug_scoring_method]> == interval:
                                        - flag <player> juggernaut_data.host_data.points:jug_interval_time
                    - if <player.flag[juggernaut_custom_settings.<[point_type]>].exists>:
                        - if <player.flag[juggernaut_custom_settings.<[point_type]>]> < 0:
                            - flag player juggernaut_custom_settings.<[point_type]>:0
                        - if <[point_type]> != jug_interval_time:
                            - if <player.flag[juggernaut_custom_settings.<[point_type]>]> > 20:
                                - flag player juggernaut_custom_settings.<[point_type]>:20
                        - else:
                            - if <player.flag[juggernaut_custom_settings.<[point_type]>]> > 600:
                                - flag player juggernaut_custom_settings.<[point_type]>:600
                - else if <[point_type]> == jug_scoring_method:
                    - choose <context.click>:
                        - case left || right:
                            - choose <player.flag[juggernaut_custom_settings.<[point_type]>]>:
                                - case kill:
                                    - flag player juggernaut_custom_settings.<[point_type]>:interval
                                - case interval:
                                    - flag player juggernaut_custom_settings.<[point_type]>:kill
                        - case drop:
                            - flag player juggernaut_custom_settings.<[point_type]>:!
                        - case number_key:
                            - choose <context.hotbar_button>:
                                - case 1:
                                    - flag <player> juggernaut_data.host_data.points:kill_juggernaut_points
                                - case 2:
                                    - flag <player> juggernaut_data.host_data.points:juggernaut_kill_points
                                - case 3:
                                    - flag <player> juggernaut_data.host_data.points:jug_scoring_method
                                - case 4:
                                    - if <player.flag[juggernaut_custom_settings.jug_scoring_method]> == interval:
                                        - flag <player> juggernaut_data.host_data.points:jug_interval_time
            - case spawn_protection:
                - if !<player.flag[juggernaut_data.host_data.spawn_protection].exists>:
                    - flag <player> juggernaut_data.host_data.spawn_protection:spawn_protection_duration
                - define protection_type:<player.flag[juggernaut_data.host_data.spawn_protection]>
                - if !<player.flag[juggernaut_custom_settings.<[protection_type]>].exists> && <context.click> != number_key:
                    - flag player juggernaut_custom_settings.<[protection_type]>:<proc[jug_config_read].context[<[protection_type]>|<[map]>].round>
                - choose <context.click>:
                    - case left:
                        - flag player juggernaut_custom_settings.<[protection_type]>:+:1
                    - case right:
                        - flag player juggernaut_custom_settings.<[protection_type]>:-:1
                    - case shift_left:
                        - flag player juggernaut_custom_settings.<[protection_type]>:+:5
                    - case shift_right:
                        - flag player juggernaut_custom_settings.<[protection_type]>:-:5
                    - case drop:
                        - flag player juggernaut_custom_settings.<[protection_type]>:!
                    - case number_key:
                        - choose <context.hotbar_button>:
                            - case 1:
                                - flag <player> juggernaut_data.host_data.spawn_protection:spawn_protection_duration
                            - case 2:
                                - flag <player> juggernaut_data.host_data.spawn_protection:spawn_protection_level
                - if <player.flag[juggernaut_custom_settings.<[protection_type]>].exists>:
                    - if <player.flag[juggernaut_custom_settings.<[protection_type]>]> < 0:
                        - flag player juggernaut_custom_settings.<[protection_type]>:0
                    - if <[protection_type]> == spawn_protection_level:
                        - if <player.flag[juggernaut_custom_settings.spawn_protection_level]> > 5:
                            - flag player juggernaut_custom_settings.spawn_protection_level:5
                    - else:
                        - if <player.flag[juggernaut_custom_settings.spawn_protection_duration]> > 30:
                            - flag player juggernaut_custom_settings.spawn_protection_duration:30
            - case victory_condition:
                - if !<player.flag[juggernaut_custom_settings.victory_conditions].exists>:
                    - flag player juggernaut_custom_settings.victory_conditions:1
                - choose <context.click>:
                    - case left:
                        - flag player juggernaut_custom_settings.victory_conditions:+:1
                    - case right:
                        - flag player juggernaut_custom_settings.victory_conditions:-:1
                    - case shift_left:
                        - flag player juggernaut_custom_settings.victory_conditions:+:5
                    - case shift_right:
                        - flag player juggernaut_custom_settings.victory_conditions:-:5
                    - case drop:
                        - flag player juggernaut_custom_settings.victory_conditions:!
                - if <player.flag[juggernaut_custom_settings.victory_conditions].exists>:
                    - if <player.flag[juggernaut_custom_settings.victory_conditions]> < 1:
                        - flag player juggernaut_custom_settings.victory_conditions:1
                    - if <player.flag[juggernaut_custom_settings.victory_conditions]> > 100:
                        - flag player juggernaut_custom_settings.victory_conditions:100
            - case resistances:
                - if !<player.flag[juggernaut_data.host_data.resistances].exists>:
                    - flag <player> juggernaut_data.host_data.resistances:base
                - define resistance_type:<player.flag[juggernaut_data.host_data.resistances]>
                - if !<player.flag[juggernaut_custom_settings.resistances.<[resistance_type]>].exists> && <context.click> != number_key:
                    - flag player juggernaut_custom_settings.resistances.<[resistance_type]>:1
                - choose <context.click>:
                    - case left:
                        - flag player juggernaut_custom_settings.resistances.<[resistance_type]>:+:0.01
                    - case right:
                        - flag player juggernaut_custom_settings.resistances.<[resistance_type]>:-:0.01
                    - case shift_left:
                        - flag player juggernaut_custom_settings.resistances.<[resistance_type]>:+:0.1
                    - case shift_right:
                        - flag player juggernaut_custom_settings.resistances.<[resistance_type]>:-:0.1
                    - case drop:
                        - flag player juggernaut_custom_settings.resistances.<[resistance_type]>:!
                    - case number_key:
                        - choose <context.hotbar_button>:
                            - case 1:
                                - flag <player> juggernaut_data.host_data.resistances:base
                            - case 2:
                                - flag <player> juggernaut_data.host_data.resistances:projectile
                            - case 3:
                                - flag <player> juggernaut_data.host_data.resistances:entity_explosion
                            - case 4:
                                - flag <player> juggernaut_data.host_data.resistances:entity_attack
                - if <player.flag[juggernaut_custom_settings.resistances.<[resistance_type]>].exists>:
                    - if <[resistance_type]> != base:
                        - if <player.flag[juggernaut_custom_settings.resistances.<[resistance_type]>]> < 0:
                            - flag player juggernaut_custom_settings.resistances.<[resistance_type]>:0
                    - else:
                        - if <player.flag[juggernaut_custom_settings.resistances.<[resistance_type]>]> < 0.01:
                            - flag player juggernaut_custom_settings.resistances.<[resistance_type]>:0.01
                    - if <player.flag[juggernaut_custom_settings.resistances.<[resistance_type]>]> > 10:
                        - flag player juggernaut_custom_settings.resistances.<[resistance_type]>:10
            - case kits:
                - inventory open d:jug_kit_host_settings_gui
                - define null_open:true
            - case saves:
                - if !<player.flag[juggernaut_data.host_data.save_slot].exists>:
                    - flag <player> juggernaut_data.host_data.save_slot:1
                - define save_slot:<player.flag[juggernaut_data.host_data.save_slot].if_null[1]>
                - choose <context.click>:
                    - case right:
                        - if <player.has_flag[jug_setup]>:
                            - narrate "<&c>You already have another chat selection active. If this is unintentional type <proc[jug_setup_proc].context[cancel|normal]><&c>!"
                            - stop
                        - if <player.has_flag[juggernaut_settings_saves.<[save_slot]>]>:
                            - if <player.has_flag[juggernaut_settings_saves.<[save_slot]>.save_name]>:
                                - define overwrite_warning "<&c>You are about to overwrite the save slot <&a><[save_slot]> <&c>named <&a><player.flag[juggernaut_settings_saves.<[save_slot]>.save_name].unescaped><&c>! If you don't want to overwrite your save, run <proc[jug_setup_proc].context[cancel|normal]><&c>!<&nl>"
                            - else:
                                - define overwrite_warning "<&c>You are about to overwrite save slot <&a><[save_slot]><&c>! If you don't want to overwrite your save, run <proc[jug_setup_proc].context[cancel|normal]><&c>!<&nl>"
                        - narrate "<[overwrite_warning].if_null[]><&7>Please type in <proc[jug_setup_proc].context[<&lt>save<&sp>name<&gt>|input]> <&7>to set the name of the save, or type <proc[jug_setup_proc].context[cancel|normal]> <&7>to cancel saving." targets:<player>
                        - flag <player> jug_setup.type:host_save
                        - flag <player> jug_setup.save_slot:<[save_slot]>
                        - inventory close
                        - define null_open:true
                    - case left:
                        - define new_settings:<player.flag[juggernaut_settings_saves.<[save_slot]>].if_null[null]>
                        - define random_status:<player.flag[juggernaut_custom_settings.random_only].exists>
                        - if !<player.flag[juggernaut_settings_saves.<[save_slot]>].exists>:
                            - narrate "<&c>You have not saved settings to that save slot yet!"
                            - stop
                        - if <[new_settings.banned_kits].exists>:
                            - foreach <[new_settings.banned_kits]>:
                                - if !<proc[jug_config_read].context[kits].contains[<[value]>]>:
                                    - define new_settings.banned_kits:<-:<[value]>
                                    - narrate "<&c><[value]> is no longer a valid kit!"
                        - flag player juggernaut_custom_settings:<[new_settings]>
                        - foreach <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.if_null[<list>]>:
                            - if <[value].flag[juggernaut_data.kit].exists> && <player.flag[juggernaut_custom_settings.random_only].exists>:
                                - flag <[value]> juggernaut_data.kit:!
                            - if <[random_status]> && !<[new_settings.random_only].exists>:
                                - narrate "<&c>The host has disabled random only, which means you can now pick your kit!" targets:<[value]>
                            - else if !<[random_status]> && <[new_settings.random_only].exists>:
                                - narrate "<&c>The host has enabled random only, which means your kit selection has been reset!" targets:<[value]>
                            - if <player.flag[juggernaut_custom_settings.banned_kits].contains[<[value].flag[juggernaut_data.kit].if_null[null]>]>:
                                - narrate "<&c>The kit you had selected has been disabled by the host! You have been reset back to using a random kit." targets:<[value]>
                                - flag <[value]> juggernaut_data.kit:!
                            - if <[value].flag[juggernaut_data.kit].exists>:
                                - inventory set d:<[value].inventory> o:<proc[jug_config_read].context[kits.<[value].flag[juggernaut_data.kit]>.gui_item]>[display_name=<&7>Selected<&sp>Kit:<&sp><&color[#<proc[jug_config_read].context[kits.<[value].flag[juggernaut_data.kit]>.primary_color]>]><&l><proc[jug_config_read].context[kits.<[value].flag[juggernaut_data.kit]>.display_name]>] slot:5
                            - else:
                                - inventory set d:<[value].inventory> o:FIREWORK_STAR[display_name=<&7>Selected<&sp>Kit:<&sp><&l>Random] slot:5
                            - foreach <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.filter_tag[<[filter_value].open_inventory.script.name.equals[jug_kit_selection_gui].if_null[false]>].if_null[<list>]>:
                                - inventory open d:jug_kit_selection_gui player:<[value]>
                    - case drop:
                        - if <player.has_flag[jug_setup]>:
                            - narrate "<&c>You already have another chat selection active. If this is unintentional type <proc[jug_setup_proc].context[cancel|normal]><&c>!"
                            - stop
                        - if <player.has_flag[juggernaut_settings_saves.<[save_slot]>]>:
                            - if <player.has_flag[juggernaut_settings_saves.<[save_slot]>.save_name]>:
                                - define overwrite_warning "<&c>You are about to remove the save slot <&a><[save_slot]> <&c>named <&a><player.flag[juggernaut_settings_saves.<[save_slot]>.save_name].unescaped><&c>! If you don't want to remove your save, run <proc[jug_setup_proc].context[cancel|normal]><&c>!<&nl>"
                            - else:
                                - define overwrite_warning "<&c>You are about to remove save slot <&a><[save_slot]><&c>! If you don't want to remove your save, run <proc[jug_setup_proc].context[cancel|normal]><&c>!<&nl>"
                        - narrate "<[overwrite_warning].if_null[]><&7>Please type in <proc[jug_setup_proc].context[confirm|normal]> <&7>to remove the save slot, or type <proc[jug_setup_proc].context[cancel|normal]> <&7>to cancel removing the save slot." targets:<player>
                        - flag <player> jug_setup.type:host_save_remove
                        - flag <player> jug_setup.save_slot:<[save_slot]>
                        - inventory close
                        - define null_open:true
                        #- flag player juggernaut_settings_saves.<[save_slot]>:!
                    - case number_key:
                        - flag <player> juggernaut_data.host_data.save_slot:<context.hotbar_button>
            - case abilities:
                - if !<player.flag[juggernaut_data.host_data.abilities].exists>:
                    - flag <player> juggernaut_data.host_data.abilities:cooldown_multiplier
                - define ability_type:<player.flag[juggernaut_data.host_data.abilities]>
                - if !<player.flag[juggernaut_custom_settings.<[ability_type]>].exists> && <context.click> != number_key:
                    - if <[ability_type]> != abilities_disabled:
                        - flag player juggernaut_custom_settings.<[ability_type]>:1
                - if <[ability_type]> != abilities_disabled:
                    - choose <context.click>:
                        - case left:
                            - flag player juggernaut_custom_settings.<[ability_type]>:+:0.01
                        - case right:
                            - flag player juggernaut_custom_settings.<[ability_type]>:-:0.01
                        - case shift_left:
                            - flag player juggernaut_custom_settings.<[ability_type]>:+:0.1
                        - case shift_right:
                            - flag player juggernaut_custom_settings.<[ability_type]>:-:0.1
                        - case drop:
                            - flag player juggernaut_custom_settings.<[ability_type]>:!
                        - case number_key:
                            - choose <context.hotbar_button>:
                                - case 1:
                                    - if !<player.flag[juggernaut_custom_settings.abilities_disabled].is_truthy>:
                                        - flag <player> juggernaut_data.host_data.abilities:cooldown_multiplier
                                - case 2:
                                    - flag <player> juggernaut_data.host_data.abilities:mana_multiplier
                                - case 3:
                                    - flag <player> juggernaut_data.host_data.abilities:abilities_disabled
                - else:
                    - choose <context.click>:
                        - case left || right:
                            - if <player.flag[juggernaut_custom_settings.<[ability_type]>].is_truthy>:
                                - flag player juggernaut_custom_settings.<[ability_type]>:false
                            - else:
                                - flag player juggernaut_custom_settings.<[ability_type]>:true
                        - case drop:
                            - flag player juggernaut_custom_settings.<[ability_type]>:!
                        - case number_key:
                            - choose <context.hotbar_button>:
                                - case 1:
                                    - if !<player.flag[juggernaut_custom_settings.abilities_disabled].is_truthy>:
                                        - flag <player> juggernaut_data.host_data.abilities:cooldown_multiplier
                                - case 2:
                                    - flag <player> juggernaut_data.host_data.abilities:mana_multiplier
                                - case 3:
                                    - flag <player> juggernaut_data.host_data.abilities:abilities_disabled
                - if <player.flag[juggernaut_custom_settings.<[ability_type]>].exists>:
                    - if <player.flag[juggernaut_custom_settings.<[ability_type]>]> < 0:
                        - flag player juggernaut_custom_settings.<[ability_type]>:0
                    - if <player.flag[juggernaut_custom_settings.<[ability_type]>]> > 5:
                        - flag player juggernaut_custom_settings.<[ability_type]>:5
            - case tracking:
                - if !<player.flag[juggernaut_data.host_data.tracking].exists>:
                    - flag <player> juggernaut_data.host_data.tracking:compass_disabled
                - define tracking_type:<player.flag[juggernaut_data.host_data.tracking]>
                - choose <context.click>:
                    - case left || right:
                        - if !<player.flag[juggernaut_custom_settings.<[tracking_type]>].is_truthy>:
                            - flag player juggernaut_custom_settings.<[tracking_type]>:true
                        - else:
                            - flag player juggernaut_custom_settings.<[tracking_type]>:false
                    - case drop:
                        - flag player juggernaut_custom_settings.<[tracking_type]>:!
                    - case number_key:
                        - choose <context.hotbar_button>:
                            - case 1:
                                - flag <player> juggernaut_data.host_data.tracking:compass_disabled
                            - case 2:
                                - flag <player> juggernaut_data.host_data.tracking:glowing_disabled
            - case health:
                - if !<player.flag[juggernaut_data.host_data.health].exists>:
                    - flag <player> juggernaut_data.host_data.health:max_health
                - define health_type:<player.flag[juggernaut_data.host_data.health].if_null[max_health]>
                - if !<player.flag[juggernaut_custom_settings.<[health_type]>].exists> && <context.click> != number_key:
                    - if <[health_type]> == max_health:
                        - flag player juggernaut_custom_settings.<[health_type]>:20
                - if <[health_type]> != regen_disabled:
                    - choose <context.click>:
                        - case left:
                            - flag player juggernaut_custom_settings.max_health:+:1
                        - case right:
                            - flag player juggernaut_custom_settings.max_health:-:1
                        - case shift_left:
                            - flag player juggernaut_custom_settings.max_health:+:10
                        - case shift_right:
                            - flag player juggernaut_custom_settings.max_health:-:10
                        - case drop:
                            - flag player juggernaut_custom_settings.max_health:!
                        - case number_key:
                            - choose <context.hotbar_button>:
                                - case 1:
                                    - flag <player> juggernaut_data.host_data.health:max_health
                                - case 2:
                                    - flag <player> juggernaut_data.host_data.health:regen_disabled
                - else if <[health_type]> == regen_disabled:
                    - choose <context.click>:
                        - case left || right:
                            - if !<player.flag[juggernaut_custom_settings.regen_disabled].is_truthy>:
                                - flag player juggernaut_custom_settings.regen_disabled:true
                            - else:
                                - flag player juggernaut_custom_settings.regen_disabled:false
                        - case drop:
                            - flag player juggernaut_custom_settings.regen_disabled:!
                        - case number_key:
                            - choose <context.hotbar_button>:
                                - case 1:
                                    - flag <player> juggernaut_data.host_data.health:max_health
                                - case 2:
                                    - flag <player> juggernaut_data.host_data.health:regen_disabled
                - if <player.flag[juggernaut_custom_settings.max_health].exists>:
                    - if <player.flag[juggernaut_custom_settings.max_health]> < 1:
                        - flag player juggernaut_custom_settings.max_health:1
                    - if <player.flag[juggernaut_custom_settings.max_health]> > 100:
                        - flag player juggernaut_custom_settings.max_health:100
            - case spawning:
                - if !<player.flag[juggernaut_custom_settings.juggernaut_spawning].exists>:
                    - flag player juggernaut_custom_settings.juggernaut_spawning:start
                - choose <context.click>:
                    - case left:
                        - choose <player.flag[juggernaut_custom_settings.juggernaut_spawning]>:
                            - case start:
                                - flag player juggernaut_custom_settings.juggernaut_spawning:always
                            - case always:
                                - flag player juggernaut_custom_settings.juggernaut_spawning:never
                            - case never:
                                - flag player juggernaut_custom_settings.juggernaut_spawning:start
                    - case right:
                        - choose <player.flag[juggernaut_custom_settings.juggernaut_spawning]>:
                            - case start:
                                - flag player juggernaut_custom_settings.juggernaut_spawning:never
                            - case always:
                                - flag player juggernaut_custom_settings.juggernaut_spawning:start
                            - case never:
                                - flag player juggernaut_custom_settings.juggernaut_spawning:always
                    - case drop:
                        - flag player juggernaut_custom_settings.juggernaut_spawning:!
            - case pvp:
                - if !<player.flag[juggernaut_data.host_data.pvp].exists>:
                    - flag <player> juggernaut_data.host_data.pvp:attack_cooldown_type
                - define pvp_type:<player.flag[juggernaut_data.host_data.pvp]>
                - if !<player.flag[juggernaut_custom_settings.<[pvp_type]>].exists> && <context.click> != number_key:
                    - choose <[pvp_type]>:
                        - case attack_cooldown_type:
                            - flag player juggernaut_custom_settings.attack_cooldown_type:1.9
                        - case combo_mode:
                            - flag player juggernaut_custom_settings.combo_mode:false
                - if <[pvp_type]> == attack_cooldown_type:
                    - choose <context.click>:
                        - case left:
                            - choose <player.flag[juggernaut_custom_settings.<[pvp_type]>]>:
                                - case 1.8:
                                    - flag player juggernaut_custom_settings.<[pvp_type]>:1.9
                                - case 1.9:
                                    - flag player juggernaut_custom_settings.<[pvp_type]>:1.8
                        - case right:
                            - choose <player.flag[juggernaut_custom_settings.<[pvp_type]>]>:
                                - case 1.8:
                                    - flag player juggernaut_custom_settings.<[pvp_type]>:1.9
                                - case 1.9:
                                    - flag player juggernaut_custom_settings.<[pvp_type]>:1.8
                        - case drop:
                            - flag player juggernaut_custom_settings.<[pvp_type]>:!
                        - case number_key:
                            - choose <context.hotbar_button>:
                                - case 1:
                                    - flag <player> juggernaut_data.host_data.pvp:attack_cooldown_type
                                - case 2:
                                    - flag <player> juggernaut_data.host_data.pvp:combo_mode
                - else:
                    - choose <context.click>:
                        - case left || right:
                            - choose <player.flag[juggernaut_custom_settings.<[pvp_type]>]>:
                                - case false:
                                    - flag player juggernaut_custom_settings.<[pvp_type]>:true
                                - case true:
                                    - flag player juggernaut_custom_settings.<[pvp_type]>:false
                        - case drop:
                            - flag player juggernaut_custom_settings.<[pvp_type]>:!
                        - case number_key:
                            - choose <context.hotbar_button>:
                                - case 1:
                                    - flag <player> juggernaut_data.host_data.pvp:attack_cooldown_type
                                - case 2:
                                    - flag <player> juggernaut_data.host_data.pvp:combo_mode
            - case host_info:
                - if !<player.flag[juggernaut_data.host_data.host_info].exists>:
                    - flag <player> juggernaut_data.host_data.host_info:1
                - choose <context.click>:
                    - case left:
                        - choose <player.flag[juggernaut_data.host_data.host_info]>:
                            - case 1:
                                - flag <player> juggernaut_data.host_data.host_info:2
                            - case 2:
                                - flag <player> juggernaut_data.host_data.host_info:3
                            - case 3:
                                - flag <player> juggernaut_data.host_data.host_info:4
                            - case 4:
                                - flag <player> juggernaut_data.host_data.host_info:1
                    - case right:
                        - choose <player.flag[juggernaut_data.host_data.host_info]>:
                            - case 1:
                                - flag <player> juggernaut_data.host_data.host_info:4
                            - case 2:
                                - flag <player> juggernaut_data.host_data.host_info:1
                            - case 3:
                                - flag <player> juggernaut_data.host_data.host_info:2
                            - case 4:
                                - flag <player> juggernaut_data.host_data.host_info:3
            - case reset_all:
                - if <context.click> == control_drop:
                    - flag player juggernaut_custom_settings:!
        - if !<[null_open].exists>:
            - if <player.has_flag[juggernaut_data.is_host]>:
                - foreach <proc[jug_viewers].context[<[map]>].filter_tag[<[filter_value].open_inventory.script.name.equals[jug_hosting_main_inv].if_null[false]>].if_null[<list>]>:
                    - inventory open d:jug_hosting_main_inv player:<[value]>
            - else:
                - inventory open d:jug_hosting_main_inv
        on player right clicks block with:jug_host_settings_item:
        - inventory open d:jug_hosting_main_inv
        on player right clicks block with:jug_custom_settings_item:
        - inventory open d:jug_custom_settings_inv
jug_host_settings_item:
    type: item
    material: DIAMOND
    display name: <&e>Host Settings
    lore:
    - <&7>Right click this item to open the host settings.
jug_custom_settings_item:
    type: item
    material: comparator
    display name: <&e>Custom Settings
    lore:
    - <&7>Right click to open the custom settings menu.
jug_kit_host_settings_gui:
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
    - define map <player.flag[juggernaut_data.map]>
    - define pageMin <[size].mul[<player.flag[gui_page].sub[1]>].add[1]>
    - define pageMax <[size].mul[<player.flag[gui_page]>]>
    - define pageList <proc[jug_config_read].context[kits].keys.get[<[pageMin]>].to[<[pageMax]>]>
    - foreach <[pageList]>:
        - define page.<[value]>:<proc[jug_config_read].context[kits.<[value]>]>
    - define list <list>
    - foreach <[page]>:
        - define prim <&color[#<[value].get[primary_color]>]>
        - define sec <&color[#<[value].get[secondary_color]>]>
        - define item <[value].get[gui_item].as_item>
        - adjust def:item display_name:<[sec]><&l><&k>;<[prim]><&l><&k>;<[sec]><&l><&k>;<&sp><[prim]><[value].get[display_name]><&sp><[sec]><&l><&k>;<[prim]><&l><&k>;<[sec]><&l><&k>;
        - adjust def:item flag:kit:<[key]>
        - adjust def:item "lore:<&7><[value.description].split_lines_by_width[250].replace[<&nl>].with[<&nl><&7>]> <&nl><&nl><&7>Enabled: <player.flag[juggernaut_custom_settings.banned_kits].contains[<[key]>].if_true[<&c>Off].if_false[<&a>On].if_null[<&a>On]>"
        - adjust def:item hides:all
        - if !<player.flag[juggernaut_custom_settings.banned_kits].contains[<[key]>].if_null[false]>:
            - adjust def:item enchantments:<map[].with[luck].as[1]>
        - define list:->:<[item]>
    - repeat <element[28].sub[<[list].size>]>:
        - define list:->:air
    - if <player.flag[gui_page]> > 1:
        - define list <[list].include[jug_prev_page_item[flag=menu:jug_kit_selection_gui]]>
    - else:
        - define list <[list].include[black_stained_glass_pane[display_name=<&sp>]]>
    - define item "<item[FIREWORK_STAR[display_name=<element[<&c><&l><&k>;<&7><&l><&k>;<&c><&l><&k>;<&sp><&7>Random Kit Only<&sp><&c><&l><&k>;<&7><&l><&k>;<&c><&l><&k>;].escaped>;lore=<&7>Force players to only choose random kits.<&nl><&nl><&7>Enabled: <player.flag[juggernaut_custom_settings.random_only].exists.if_true[<&a>On].if_false[<&c>Off]>;flag=kit:random;hides=all]]>"
    - if <player.flag[juggernaut_custom_settings.random_only].exists>:
        - adjust def:item enchantments:<map[].with[luck].as[1]>
    - define list:->:<[item]>
    - if <proc[jug_config_read].context[kits].keys.get[<[pageMax].add[1]>].exists>:
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
jug_kit_host_settings_click:
    type: world
    debug: false
    events:
        on player clicks item_flagged:kit in jug_kit_host_settings_gui:
        - define kit <context.item.flag[kit]>
        - define map <player.flag[juggernaut_data.map]>
        - if <[kit]> != random:
            - choose <context.click>:
                - case left || right:
                    - if !<player.flag[juggernaut_custom_settings.banned_kits].contains[<[kit]>].if_null[false]>:
                        - if <player.flag[juggernaut_custom_settings.banned_kits].size.add[1].if_null[0]> >= <proc[jug_config_read].context[kits].keys.size>:
                            - narrate "<&c>There must be at least one choosable kit!"
                            - stop
                        - flag <player> juggernaut_custom_settings.banned_kits:->:<[kit]>
                    - else:
                        - flag <player> juggernaut_custom_settings.banned_kits:<-:<[kit]>
                        - if <player.flag[juggernaut_custom_settings.banned_kits].size> <= 0:
                            - flag <player> juggernaut_custom_settings.banned_kits:!
                - case shift_left:
                    - define kits <proc[jug_config_read].context[kits].keys.exclude[<[kit]>]>
                    - if <player.flag[juggernaut_custom_settings.banned_kits].contains[<[kit]>].if_null[false]>:
                        - flag <player> juggernaut_custom_settings.banned_kits:<-:<[kit]>
                    - foreach <[kits]>:
                        - if !<player.flag[juggernaut_custom_settings.banned_kits].contains[<[value]>].if_null[false]>:
                            - flag <player> juggernaut_custom_settings.banned_kits:->:<[value]>
                - case shift_right:
                    - flag <player> juggernaut_custom_settings.banned_kits:!
        - else:
            - if !<player.flag[juggernaut_custom_settings.random_only].exists>:
                - flag <player> juggernaut_custom_settings.random_only:true
                - if <[map].exists>:
                    - foreach <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.if_null[<list>]>:
                        - narrate "<&c>The host has enabled random only, which means your kit selection has been reset!" targets:<[value]>
                        - flag <[value]> juggernaut_data.kit:!
                        - inventory set d:<[value].inventory> o:FIREWORK_STAR[display_name=<&7>Selected<&sp>Kit:<&sp><&l>Random] slot:5
            - else:
                - flag <player> juggernaut_custom_settings.random_only:!
                - if <[map].exists>:
                    - foreach <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.if_null[<list>]>:
                        - narrate "<&c>The host has disabled random only, which means you can now pick your kit!" targets:<[value]>
        - if <[map].exists>:
            - foreach <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.filter_tag[<player.flag[juggernaut_custom_settings.banned_kits].contains[<[filter_value].flag[juggernaut_data.kit]>]>].if_null[<list>]>:
                - narrate "<&c>The kit you had selected has been disabled by the host! You have been reset back to using a random kit." targets:<[value]>
                - flag <[value]> juggernaut_data.kit:!
                - inventory set d:<[value].inventory> o:FIREWORK_STAR[display_name=<&7>Selected<&sp>Kit:<&sp><&l>Random] slot:5
            - foreach <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.filter_tag[<[filter_value].open_inventory.script.name.equals[jug_kit_selection_gui]>].if_null[<list>]>:
                - inventory open d:jug_kit_selection_gui player:<[value]>
        - inventory open d:jug_kit_host_settings_gui
jug_ability_cooldown_proc:
    type: procedure
    definitions: player_type|map|ability
    debug: false
    script:
    - if <[ability.mininum_cooldown].exists>:
        - determine <[ability.cooldown.<[player_type]>].if_null[<[ability.cooldown]>].mul[<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.cooldown_multiplier].if_null[1]>].max[<[ability.mininum_cooldown]>]>
    - else:
        - determine <[ability.cooldown.<[player_type]>].if_null[<[ability.cooldown]>].mul[<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.cooldown_multiplier].if_null[1]>]>
jug_new_juggernaut_task:
    type: task
    definitions: killer|map
    debug: false
    script:
    - define victim <player>
    - run JUG_GIVE_POINTS_TASK def:<[map]>|kill_juggernaut|<[victim]> player:<[killer]>
    #- flag server juggernaut_maps.<[map]>.game_data.players.<[killer]>.score:+:<proc[jug_config_read].context[kill_juggernaut_points|<[map]>]>
    #- flag server juggernaut_maps.<[map]>.game_data.players.<[killer]>.score_time:<util.time_now>
    - flag server juggernaut_maps.<[map]>.game_data.juggernaut:<[killer]>
    - flag <player> juggernaut_data.is_juggernaut:!
    - flag <[killer]> juggernaut_data.is_juggernaut:true
    - cast glowing remove <player>
    - if !<[killer].has_flag[juggernaut_data.invis]> && !<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.glowing_disabled].is_truthy> && !<[killer].has_flag[juggernaut_data.dead]>:
        - cast glowing duration:10000s <[killer]> no_icon hide_particles
    - if !<[killer].has_flag[juggernaut_data.dead]>:
        - inventory set d:<[killer].inventory> o:player_head[skull_skin=69a4ed90-c7d1-4236-9f39-b8fb6e599c70|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTU5NTNkNjMxMjlmNTIwNWJjZGE5NmM5MWMwNzBjYjFkMzlkMTU1NWQ1ZGZjNDM4MThkNzM3ODg3YzNkMSJ9fX0] slot:40
    - title 'title:<&c>You are now the Juggernaut!' targets:<[killer]>
    - narrate "<&a><&l>⚑ <&c><[killer].name> <&7>is now the juggernaut! They now have <&a><server.flag[juggernaut_maps.<[map]>.game_data.players.<[killer]>.score]> <&7>point<proc[jug_plural_s].context[<server.flag[juggernaut_maps.<[map]>.game_data.players.<[killer]>.score]>]>" targets:<proc[jug_viewers].context[<[map]>]>
    - run jug_update_sidebar def:<[map]>|on|<[killer]>
    - run jug_juggernaut_slowness def:<[map]> player:<[killer]>
    - run JUG_KIT_DISPLAY def:update player:<[killer]>
    - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.juggernaut_spawning].if_null[null]> == always:
        - teleport <[killer]> to:<server.flag[juggernaut_maps.<[map]>.jug_spawn]>
    - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.jug_scoring_method].if_null[null]> == interval:
        - run jug_juggernaut_interval_task def:<[map]> player:<[killer]>
jug_settings_value_proc:
    type: procedure
    definitions: source_type|source|value_type
    debug: false
    script:
    # Figure out how to get this to work with player's settings to. Granted, lots of problems will come when players can do settings
    #- if <[source_type]> == map:
        #- define key <server.flag[juggernaut_maps.<[source]>.host_data.host].flag[juggernaut_custom_settings].if_null[null]>
    - if <player.has_flag[juggernaut_data.in_game]>:
        - define map <player.flag[juggernaut_data.map]>
        - if <[source_type]> == player_vote:
            - define key <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_options.<[source]>]>
        - else if <[source_type]> == map:
            - define key <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings]>
        - else:
            - if <server.flag[juggernaut_maps.<[map]>.host_data.host].exists>:
                - if <server.flag[juggernaut_maps.<[map]>.game_data.phase]> < 2:
                    - define key <server.flag[juggernaut_maps.<[source]>.host_data.host].flag[juggernaut_custom_settings].if_null[null]>
                - else:
                    - define key <server.flag[juggernaut_maps.<[source]>.game_data.custom_settings].if_null[null]>
    - else:
        - define key <player.flag[juggernaut_custom_settings].if_null[null]>
    - choose <[value_type]>:
        - case respawn_timer:
            - if <[key.respawn_timer].exists>:
                - determine "<&7>Respawn Timer: <&e><[key.respawn_timer]>s"
            - else:
                - determine "<&7>Respawn Timer: <&e>Default (<proc[jug_config_read].context[respawn_timer|<[source]>]>s)"
        - case kill_juggernaut_points:
            - if <[key.kill_juggernaut_points].exists>:
                - determine "<&7>Kill Juggernaut Points: <&e><[key.kill_juggernaut_points]>"
            - else:
                - determine "<&7>Kill Juggernaut Points: <&e>Default (<proc[jug_config_read].context[kill_juggernaut_points|<[source]>]>)"
        - case juggernaut_kill_points:
            - if <[key.juggernaut_kill_points].exists>:
                - if <[key.jug_scoring_method].if_null[null]> != interval:
                    - determine "<&7>Juggernaut Kill Points: <&e><[key.juggernaut_kill_points]>"
                - else:
                    - determine "<&7>Juggernaut Survival Points: <&e><[key.juggernaut_kill_points]>"
            - else:
                - if <[key.jug_scoring_method].if_null[null]> != interval:
                    - determine "<&7>Juggernaut Kill Points: <&e>Default (<proc[jug_config_read].context[juggernaut_kill_points|<[source]>]>)"
                - else:
                    - determine "<&7>Juggernaut Survival Points: <&e>Default (<proc[jug_config_read].context[juggernaut_kill_points|<[source]>]>)"
        - case jug_scoring_method:
            - if <[key.jug_scoring_method].exists>:
                - choose <[key.jug_scoring_method]>:
                    - case kill:
                        - determine "<&7>Juggernaut Scoring Method: <&e>Kill"
                    - case interval:
                        - determine "<&7>Juggernaut Scoring Method: <&e>Interval"
            - else:
                - determine "<&7>Juggernaut Scoring Method: <&e>Default (Kill)"
        - case jug_interval_time:
            - if <[key.jug_scoring_method].if_null[null]> == interval:
                - if <[key.jug_interval_time].exists>:
                    - determine "<&7>Juggernaut Survival Interval: <&e><[key.jug_interval_time]>s"
                - else:
                    - determine "<&7>Juggernaut Survival Interval: <&e>Default (30s)"
            - else:
                - if <[key.jug_interval_time].exists>:
                    - determine "<&7>Juggernaut Survival Interval: <&8><&m><[key.jug_interval_time]>s"
                - else:
                    - determine "<&7>Juggernaut Survival Interval: <&8><&m>Default (30s)"
        - case spawn_protection_duration:
            - if <[key.spawn_protection_duration].exists>:
                - determine "<&7>Spawn Protection Duration: <&e><[key.spawn_protection_duration]>s"
            - else:
                - determine "<&7>Spawn Protection Duration: <&e>Default (<proc[jug_config_read].context[spawn_protection_duration|<[source]>]>s)"
        - case spawn_protection_level:
            - if <[key.spawn_protection_level].exists>:
                - determine "<&7>Spawn Protection Level: <&e><[key.spawn_protection_level]>"
            - else:
                - determine "<&7>Spawn Protection Level: <&e>Default (<proc[jug_config_read].context[spawn_protection_level|<[source]>]>)"
        - case victory_conditions:
            - if <[key.victory_conditions].exists>:
                - determine "<&7>Victory Condition: <&e><[key.victory_conditions]>"
            - else:
                - determine "<&7>Victory Condition: <&e>Default (Varies)"
        - case juggernaut_base_resistance:
            - if <[key.resistances.base].exists>:
                - determine "<&7>Juggernaut Base Resistance: <&e><[key.resistances.base]>x"
            - else:
                - determine "<&7>Juggernaut Base Resistance: <&e>Default (Varies)"
        - case juggernaut_projectile_resistance:
            - if <[key.resistances.projectile].exists>:
                - determine "<&7>Juggernaut Projectile Resistance: <&e><[key.resistances.projectile]>x"
            - else:
                - determine "<&7>Juggernaut Projectile Resistance: <&e>Default (Varies)"
        - case juggernaut_entity_explosion_resistance:
            - if <[key.resistances.entity_explosion].exists>:
                - determine "<&7>Juggernaut Explosion Resistance: <&e><[key.resistances.entity_explosion]>x"
            - else:
                - determine "<&7>Juggernaut Explosion Resistance: <&e>Default (Varies)"
        - case juggernaut_entity_attack_resistance:
            - if <[key.resistances.entity_attack].exists>:
                - determine "<&7>Juggernaut Attack Resistance: <&e><[key.resistances.entity_attack]>x"
            - else:
                - determine "<&7>Juggernaut Attack Resistance: <&e>Default (Varies)"
        - case banned_kits:
            - if <[key.banned_kits].exists>:
                - determine "<&7>Disabled Kits: <&e><[key.banned_kits].parse_tag[<proc[jug_config_read].context[kits.<[parse_value]>.display_name]>].comma_separated.split_lines_by_width[325].replace_text[<&nl>].with[<&nl><&e>]>"
            - else:
                - determine "<&7>Disabled Kits: <&e>None"
        - case random_only:
            - if <[key.random_only].exists>:
                - determine "<&7>Random Kit Only: <&a>Enabled"
            - else:
                - determine "<&7>Random Kit Only: <&c>Disabled"
        - case cooldown_multiplier:
            - if !<[key.abilities_disabled].is_truthy>:
                - if <[key.cooldown_multiplier].exists>:
                    - determine "<&7>Ability Cooldown Multiplier: <&e><[key.cooldown_multiplier]>x"
                - else:
                    - determine "<&7>Ability Cooldown Multiplier: <&e>Default (1x)"
            - else:
                - if <[key.cooldown_multiplier].exists>:
                    - determine "<&7>Ability Cooldown Multiplier: <&8><&m><[key.cooldown_multiplier]>x"
                - else:
                    - determine "<&7>Ability Cooldown Multiplier: <&8><&m>Default (1x)"
        - case mana_multiplier:
            - if <[key.mana_multiplier].exists>:
                - determine "<&7>Mana Regeneration Multiplier: <&e><[key.mana_multiplier]>x"
            - else:
                - determine "<&7>Mana Regeneration Multiplier: <&e>Default (1x)"
        - case abilities_disabled:
            - if <[key.abilities_disabled].exists>:
                - if <[key.abilities_disabled].is_truthy>:
                    - determine "<&7>Abilities: <&c>Disabled"
                - else:
                    - determine "<&7>Abilities: <&a>Enabled"
            - else:
                - determine "<&7>Abilities: <&e>Default (<&a>Enabled<&e>)"
        - case compass_disabled:
            - if <[key.compass_disabled].exists>:
                - if <[key.compass_disabled].is_truthy>:
                    - determine "<&7>Juggernaut Tracker: <&c>Disabled"
                - else:
                    - determine "<&7>Juggernaut Tracker: <&a>Enabled"
            - else:
                - determine "<&7>Juggernaut Tracker: <&e>Default (<&a>Enabled<&e>)"
        - case glowing_disabled:
            - if <[key.glowing_disabled].exists>:
                - if <[key.glowing_disabled].is_truthy>:
                    - determine "<&7>Juggernaut Glowing: <&c>Disabled"
                - else:
                    - determine "<&7>Juggernaut Glowing: <&a>Enabled"
            - else:
                - determine "<&7>Juggernaut Glowing: <&e>Default (<&a>Enabled<&e>)"
        - case max_health:
            - if <[key.max_health].exists>:
                - determine "<&7>Max Health: <&e><[key.max_health]>"
            - else:
                - determine "<&7>Max Health: <&e>Default (20)"
        - case regen_disabled:
            - if <[key.regen_disabled].exists>:
                - if <[key.regen_disabled].is_truthy>:
                    - determine "<&7>Natural Health Regeneration: <&c>Disabled"
                - else:
                    - determine "<&7>Natural Health Regeneration: <&a>Enabled"
            - else:
                - determine "<&7>Natural Health Regeneration: <&e>Default (<&a>Enabled<&e>)"
        - case juggernaut_spawning:
            - if <[key.juggernaut_spawning].exists>:
                - choose <[key.juggernaut_spawning]>:
                    - case never:
                        - determine "<&7>Juggernaut Spawning: <&e>Never"
                    - case always:
                        - determine "<&7>Juggernaut Spawning: <&e>Every New Juggernaut"
                    - case start:
                        - determine "<&7>Juggernaut Spawning: <&e>Start Of Game"
            - else:
                - determine "<&7>Juggernaut Spawning: <&e>Default (Start Of Game)"
        - case attack_cooldown_type:
            - if <[key.attack_cooldown_type].exists>:
                - choose <[key.attack_cooldown_type]>:
                    - case 1.8:
                        - determine "<&7>PvP Attack Cooldown Type: <&e>1.8"
                    - case 1.9:
                        - determine "<&7>PvP Attack Cooldown Type: <&e>1.9+"
            - else:
                - determine "<&7>PvP Attack Cooldown Type: <&e>Default (1.9+)"
        - case combo_mode:
            - if <[key.combo_mode].exists>:
                - if <[key.combo_mode].is_truthy>:
                    - determine "<&7>Combo Mode: <&a>Enabled"
                - else:
                    - determine "<&7>Combo Mode: <&c>Disabled"
            - else:
                - determine "<&7>Combo Mode: <&e>Default (<&c>Disabled<&e>)"
jug_settings_list_proc:
    type: procedure
    definitions: source_type|source
    debug: false
    script:
    - define list:<list>
    - if <[source_type]> != player_vote:
        - define "list:->:<&e><&l>Custom Settings:"
    - if <[source_type]> == map:
        - define input:<server.flag[juggernaut_maps.<[source]>.game_data.custom_settings]>
    - if <[source_type]> == player_vote:
        - define input:<server.flag[juggernaut_maps.<player.flag[juggernaut_data.map]>.game_data.custom_settings_options.<[source]>]>
    - if !<[input].is_truthy>:
        - determine <&7>None
    - foreach <[input]>:
        - choose <[key]>:
            - case resistances:
                - foreach <[value].keys> as:value2:
                    - define list:->:<proc[jug_settings_value_proc].context[<[source_type]>|<[source]>|juggernaut_<[value2]>_resistance]>
            - case save_name:
                - foreach next
            - default:
                - define list:->:<proc[jug_settings_value_proc].context[<[source_type]>|<[source]>|<[key]>]>
    - determine <[list].separated_by[<&nl>]>
jug_trap_particles:
    type: task
    debug: false
    definitions: loc|abilities
    script:
    - define angle 0
    - if <player.has_flag[juggernaut_data.is_juggernaut]>:
        - define player_type juggernaut
    - else:
        - define player_type player
    - define rad <[abilities.trap_radius.<[player_type]>].if_null[<[abilities.trap_radius]>]>
    - define wind <[abilities.trap_windup_duration.<[player_type]>].if_null[<[abilities.trap_windup_duration]>]>
    - define act <[abilities.trap_active_duration.<[player_type]>].if_null[<[abilities.trap_active_duration]>]>
    - define tstun <[abilities.trap_stun_duration.<[player_type]>].if_null[<[abilities.trap_stun_duration]>]>
    - define hstun <[abilities.hit_stun_amount.<[player_type]>].if_null[<[abilities.hit_stun_amount]>]>
    - repeat <[wind].mul[20]> as:rep1:
        - repeat 5:
            - playeffect effect:CRIT at:<[loc].with_yaw[<[angle]>].with_pitch[0].add[0,0.5,0].forward[<[rep1].mul[<[rad].div[<[wind].mul[20]>]>]>]> quantity:1 offset:0,0,0 visibility:200
            - define angle:+:4
        - wait 1t
    - repeat <[act].mul[20]>:
        - repeat 5:
            - playeffect effect:CRIT at:<[loc].with_yaw[<[angle]>].with_pitch[0].add[0,0.5,0].forward[<[rad]>]> quantity:1 offset:0,0,0 visibility:200
            - define angle:+:4
            - if <[loc].find_players_within[<[rad]>].exclude[<server.online_players.exclude[<proc[jug_opponents_proc].context[alive]>]>].size> > 0:
                - define trapped <[loc].find_players_within[<[rad]>].exclude[<server.online_players.exclude[<proc[jug_opponents_proc].context[alive]>]>].first>
                - repeat 90:
                    - playeffect effect:REDSTONE special_data:2|red at:<[loc].with_yaw[<[angle]>].with_pitch[0].add[0,0.5,0].forward[3]> quantity:1 offset:0,0,0 visibility:200
                    - define angle:+:4
                - definemap attributes:
                    generic_movement_speed:
                        1:
                            operation: ADD_NUMBER
                            amount: -100
                            id: <util.random.uuid>
                - inventory adjust d:<[trapped]> slot:37 add_attribute_modifiers:<[attributes]>
                - run jug_give_nojump def:3 player:<[trapped]>
                - playsound <[trapped]> sound:BLOCK_ANVIL_LAND pitch:0 volume:0.5
                - playsound <player> sound:BLOCK_ANVIL_LAND pitch:2 volume:0.5
                - wait <[tstun]>s
                - inventory adjust d:<[trapped]> slot:37 remove_attribute_modifiers:<list[<[attributes.generic_movement_speed.1.id]>]>
                - stop
        - wait 1t
jug_trap_event:
    type: world
    debug: false
    events:
        on entity_flagged:jug_trap_snowball hits block:
        - run jug_trap_particles def:<context.location.add[<context.hit_face>]>|<context.projectile.flag[abilities]> player:<context.shooter>
        on entity_flagged:jug_trap_snowball hits player flagged:juggernaut_data.in_game:
        - adjust <queue> linked_player:<context.shooter>
        - run jug_trap_particles def:<context.hit_entity.location>|<context.projectile.flag[abilities]> player:<context.shooter>
        - if <proc[jug_opponents_proc].context[alive].contains_any[<context.hit_entity>]>:
            - define abilities <context.projectile.flag[abilities]>
            - if <player.has_flag[juggernaut_data.is_juggernaut]>:
                - define player_type juggernaut
            - else:
                - define player_type player
            - define wind <[abilities.trap_windup_duration.<[player_type]>].if_null[<[abilities.trap_windup_duration]>]>
            - define hstun <[abilities.hit_stun_amount.<[player_type]>].if_null[<[abilities.hit_stun_amount]>]>
            - definemap attributes:
                generic_movement_speed:
                    1:
                        operation: ADD_NUMBER
                        amount: -<[hstun]>
                        id: <util.random.uuid>
            - inventory adjust d:<context.hit_entity> slot:37 add_attribute_modifiers:<[attributes]>
            - run jug_give_nojump def:2 player:<context.hit_entity>
            - playsound <context.shooter> sound:ENTITY_ARROW_HIT_PLAYER
            - wait <[wind]>s
            - inventory adjust d:<context.hit_entity> slot:37 remove_attribute_modifiers:<list[<[attributes.generic_movement_speed.1.id]>]>
jug_give_nojump:
    type: task
    definitions: sec
    debug: false
    script:
    - define id <util.random_uuid>
    - if !<player.has_flag[juggernaut_data.no_jump_list]>:
        - flag <player> juggernaut_data.no_jump_list:<list>
    - flag <player> juggernaut_data.no_jump_list:->:<[id]>
    - wait <[sec]>s
    - flag <player> juggernaut_data.no_jump_list:<-:<[id]>
    - if <player.flag[juggernaut_data.no_jump_list].size> < 1:
        - flag <player> juggernaut_data.no_jump_list:!
jug_opponents_proc:
    type: procedure
    definitions: state
    debug: false
    script:
    - define map <player.flag[juggernaut_data.map]>
    - define players <list>
    - choose <[state]>
    - if <player.has_flag[juggernaut_data.is_juggernaut]>:
        - define players <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.filter_tag[<[filter_value].has_flag[juggernaut_data.is_juggernaut].not>].parse_tag[<[parse_value].as_player>]>
    - else:
        - define players:->:<server.flag[juggernaut_maps.<[map]>.game_data.juggernaut]>
    - choose <[state]>:
        - case alive:
            - determine <[players].filter_tag[<[filter_value].has_flag[juggernaut_data.dead].not>]>
        - case dead:
            - determine <[players].filter_tag[<[filter_value].has_flag[juggernaut_data.dead]>]>
        - case all:
            - determine <[players].if_null[<list>]>
jug_allies_proc:
    type: procedure
    definitions: state
    debug: false
    script:
    - define map <player.flag[juggernaut_data.map]>
    - define players <list>
    - if <player.has_flag[juggernaut_data.is_juggernaut]>:
        - define players:->:<server.flag[juggernaut_maps.<[map]>.game_data.juggernaut].as_player>
    - else:
        - define players <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.filter_tag[<[filter_value].has_flag[juggernaut_data.is_juggernaut].not>].parse_tag[<[parse_value].as_player>]>
    - choose <[state]>:
        - case alive:
            - determine <[players].filter_tag[<[filter_value].has_flag[juggernaut_data.dead].not>]>
        - case dead:
            - determine <[players].filter_tag[<[filter_value].has_flag[juggernaut_data.dead]>]>
        - case all:
            - determine <[players].if_null[<list>]>
jug_juggernaut_interval_task:
    type: task
    definitions: map
    debug: false
    script:
    - if <player.has_flag[juggernaut_data.in_game]>:
        - define life_id <player.flag[juggernaut_data.life_id].if_null[0]>
        - define time_counted 0
        - define time_interval <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.jug_interval_time].if_null[30]>
        - define id <util.random_uuid>
        - bossbar create <[id]> players:<proc[jug_viewers].context[<[map]>]> "title:<&c>Juggernaut Gets Point In <&l><[time_interval].sub[<[time_counted]>]>s" progress:0 color:red style:SOLID
        - while <[time_counted]> < <[time_interval]>:
            - if <[life_id]> == <player.flag[juggernaut_data.life_id].if_null[0]> && <player.is_online> && <player.has_flag[juggernaut_data.in_game]>:
                - wait 0.1s
                - define time_counted:+:0.1
                - bossbar update <[id]> "title:<&c>Juggernaut Gets Point In <&l><[time_interval].sub[<[time_counted]>]>s" progress:<[time_counted].div[<[time_interval]>]>
            - else:
                - bossbar remove <[id]>
                - stop
        - if <[life_id]> == <player.flag[juggernaut_data.life_id].if_null[0]> && <player.is_online> && <player.has_flag[juggernaut_data.in_game]>:
            - run JUG_GIVE_POINTS_TASK def:<[map]>|juggernaut_interval| player:<player>
            #- flag server juggernaut_maps.<[map]>.game_data.players.<player>.score:+:<proc[jug_config_read].context[juggernaut_kill_points|<[map]>]>
            #- flag server juggernaut_maps.<[map]>.game_data.players.<player>.score_time:<util.time_now>
            - narrate "<&c><&l>⚑ <&c><player.name> <&7>has survived <&e><server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.jug_interval_time].if_null[30]>s <&7>as the juggernaut." targets:<proc[jug_viewers].context[<[map]>]>
            - narrate "<&a><&l>⚑ <&c><player.name> <&7>now has <&a><server.flag[juggernaut_maps.<[map]>.game_data.players.<player>.score]> <&7>point<proc[jug_plural_s].context[<server.flag[juggernaut_maps.<[map]>.game_data.players.<player>.score]>]>" targets:<proc[jug_viewers].context[<[map]>]>
            - run jug_update_sidebar def:<[map]>|on|<player>
            - run jug_juggernaut_interval_task def:<[map]> player:<player>
            - bossbar remove <[id]>
jug_grappling_hook:
    type: task
    definitions: player_type|ability|item
    debug: false
    script:
    - define vector:<player.eye_location>
    - define distance:<[ability.distance.<[player_type]>].if_null[<[ability.distance]>]>
    - define hook_speed:<[ability.hook_speed.<[player_type]>].if_null[<[ability.hook_speed]>]>
    - define launch_speed:<[ability.launch_speed.<[player_type]>].if_null[<[ability.launch_speed]>]>
    - define life_id <player.flag[juggernaut_data.life_id].if_null[0]>
    - repeat <[distance].div[<[hook_speed]>]>:
        - define loc <[vector].forward[<[value].mul[<[hook_speed]>]>]>
        - define totDis <[value].mul[<[hook_speed]>]>
        - playeffect effect:crit at:<[loc]> offset:0,0,0 visibility:200
        - if <[loc].material.name> != air && <[loc].material.name> != water:
            - define origin <player.location>
            - repeat <[totDis].mul[2].div[<[launch_speed].mul[2.5]>].round.max[1]>:
                - adjust <player> velocity:<[loc].sub[<player.location>].normalize.mul[<[launch_speed]>]>
                - adjust <player> fall_distance:0
                - wait 1t
            - stop
        - define wait_time:+:0.01
        - if <[wait_time]> >= 0.05:
            - wait 0.05s
            - define count:+:1
            - define wait_time:-:0.05
    - if <[life_id]> == <player.flag[juggernaut_data.life_id].if_null[0]> && <player.has_flag[juggernaut_data.ability_cooldowns.<[item]>]>:
        - flag <player> juggernaut_data.ability_cooldown_reductions.<[item]>:<[ability.miss_cooldown_reduction.<[player_type]>].if_null[<[ability.miss_cooldown_reduction]>]>
        - narrate "<&d><&l>✦ <&5>You have been granted an ability cooldown reduction of <&d><&l><[ability.miss_cooldown_reduction.<[player_type]>].if_null[<[ability.miss_cooldown_reduction]>].mul[100]><&pc> <&5>due to having missed your ability."
jug_gradient:
    type: procedure
    definitions: text|colors|modifiers
    debug: false
    script:
    - define cols <[colors].split[/].parse_tag[<color[<[parse_value]>]>]>
    - define mods <[modifiers].split[/]>
    - define test <list>
    - define r <[cols].get[1].red>
    - define g <[cols].get[1].green>
    - define b <[cols].get[1].blue>
    - define rd <[r].sub[<[cols].get[2].red>].div[<[text].length>]>
    - define gd <[g].sub[<[cols].get[2].green>].div[<[text].length>]>
    - define bd <[b].sub[<[cols].get[2].blue>].div[<[text].length>]>
    - repeat <[text].length>:
        - define color <color[#000000].with_red[<[r].sub[<[rd].mul[<[value]>]>].round>].with_green[<[g].sub[<[gd].mul[<[value]>]>].round>].with_blue[<[b].sub[<[bd].mul[<[value]>]>].round>]>
        - define char <[text].substring[<[value]>,<[value]>].color[<[color]>]>
        - foreach <[mods]>:
            - if <[value]> == bold:
                - define char <[char].bold>
            - else if <[value]> == italic:
                - define char <[char].italicize>
            - else if <[value]> == obfuscate:
                - define char <[char].obfuscate>
            - else if <[value]> == underline:
                - define char <[char].underline>
            - else if <[value]> == strikethrough:
                - define char <[char].strikethrough>
        - define test:->:<[char]>
    - determine <[test].separated_by[]>
jug_give_points_task:
    type: task
    definitions: map|type|victim
    debug: false
    script:
    - choose <[type]>:
        - case kill_juggernaut:
            - define amount:<proc[jug_config_read].context[kill_juggernaut_points|<[map]>]>
        - case juggernaut_kill:
            - define amount:<proc[jug_config_read].context[juggernaut_kill_points|<[map]>]>
        - case juggernaut_interval:
            - define amount:<proc[jug_config_read].context[juggernaut_kill_points|<[map]>]>
    - flag server juggernaut_maps.<[map]>.game_data.players.<player>.score:+:<[amount]>
    - flag server juggernaut_maps.<[map]>.game_data.players.<player>.score_time:<util.time_now>
    - definemap history:
        amount: <[amount]>
        time: <util.time_now.duration_since[<server.flag[juggernaut_maps.<[map]>.game_data.time_started]>]>
        type: <[type]>
    - if <[victim].exists>:
        - define history.victim:<[victim]>
    - flag server juggernaut_maps.<[map]>.game_data.players.<player>.score_history:->:<[history]>
jug_score_history_proc:
    type: procedure
    definitions: map|player
    debug: false
    script:
    - if <server.flag[juggernaut_maps.<[map]>.game_data.players.<[player]>.score_history].size.if_null[0]> > 0:
        - foreach <server.flag[juggernaut_maps.<[map]>.game_data.players.<[player]>.score_history]>:
            - choose <[value.type]>:
                - case kill_juggernaut:
                    - define cause "<&7>Killed <&c><[value.victim].name>"
                - case juggernaut_kill:
                    - define cause "<&7>Killed <&e><[value.victim].name>"
                - case juggernaut_interval:
                    - define cause "<&7>Survived <&e><server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.jug_interval_time].if_null[30]>s"
            - define min <[value.time].in_minutes.round_down.pad_left[2].with[0]>
            - define sec <[value.time].in_seconds.sub[<[min].mul[60]>].round_down.pad_left[2].with[0]>
            - define "text:->:<&e><[min]>:<[sec]> - <&a>(+<[value.amount]>) <[cause]>"
        - determine <[text].separated_by[<&nl>]>
    - else:
        - determine <&7>N/A
jug_interact_deny:
    type: world
    debug: false
    events:
        on player flagged:juggernaut_data.in_game right clicks block:
        - if !<context.location.material.vanilla_tags.exists>:
            - stop
        - if <context.location.material.vanilla_tags.contains[trapdoors]>:
            - determine passively cancelled
        - if <context.location.material.vanilla_tags.contains[doors]> && <player.has_flag[juggernaut_data.spectator]>:
            - determine passively cancelled
jug_custom_settings_inv:
  type: inventory
  inventory: CHEST
  title: Settings Voting
  size: 54
  gui: true
  debug: false
  definitions:
    g: black_stained_glass_pane[display_name=<&sp>]
  procedural items:
    - define map <player.flag[juggernaut_data.map].if_null[]>
    - define list <list>
    - define settings_size <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_options].if_null[<list>].size>
    - if !<server.flag[juggernaut_maps.<[map]>.host_data.host].exists>:
        - define item:<item[comparator]>
        - adjust def:item "display_name:<&e><&l>Current Vote Winner"
        - adjust def:item lore:<&e><proc[jug_custom_settings_top_display].context[<[map]>]>
        - define list:->:<[item]>
    - else:
        - define list:->:black_stained_glass_pane[display_name=<&sp>]
    - foreach <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_options].if_null[<list>]>:
        - define item:<item[player_head]>
        - adjust def:item skull_skin:<[key].uuid>
        - adjust def:item display_name:<&e><[value.save_name]>
        - define lore:<list>
        - if !<server.flag[juggernaut_maps.<[map]>.host_data.host].exists>:
            - if <player.flag[juggernaut_data.settings_vote].if_null[null]> == <[key]>:
                - define "lore:->:<&a><&o>You voted for these settings!"
            - define "lore:->:<&e>Votes: <&a><&l><server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_votes.<[key]>].if_null[0]><&nl>"
        - define "lore:->:<&7>Made by <&f><[key].name><&nl>"
        - define lore:->:<proc[jug_settings_list_proc].context[player_vote|<[key]>]>
        - adjust def:item lore:<[lore]>
        - adjust def:item flag:jug_data.type:submitted_setting
        - adjust def:item flag:jug_data.setting:<[key]>
        - define list:->:<[item]>
    - repeat <element[21].sub[<[settings_size]>]>:
        - define list:->:<item[air]>
    - if !<server.flag[juggernaut_maps.<[map]>.host_data.host].exists>:
        - define item:<item[redstone]>
        - adjust def:item "display_name:<&e>Default Settings"
        - define lore:<list>
        - if <player.flag[juggernaut_data.settings_vote].if_null[null]> == default:
            - define "lore:->:<&a><&o>You voted for these settings!"
        - define "lore:->:<&e>Votes: <&a><&l><server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_votes.default].if_null[0]>"
        - adjust def:item lore:<[lore]>
        - adjust def:item flag:jug_data.type:submitted_setting
        - adjust def:item flag:jug_data.setting:default
        - define list:->:<[item]>
    - else:
        - define list:->:black_stained_glass_pane[display_name=<&sp>]
    - define item:<item[repeater]>
    - adjust def:item "display_name:<&e>Settings Submission"
    - define lore <list>
    - if !<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_options.<player>].exists>:
        - repeat 9:
            - define "lore:->:<&7>[<[value]>] <&7>Slot <[value]>: <&e><player.flag[juggernaut_settings_saves.<[value]>].exists.if_true[<player.flag[juggernaut_settings_saves.<[value]>.save_name].exists.if_true[<&a><player.flag[juggernaut_settings_saves.<[value]>.save_name].unescaped>].if_false[<&a>Used <&c>(Unnamed!)]>].if_false[<&c>Empty]>"
        - adjust def:item "lore:<&7>Select a save to submit for the vote! <&nl><[lore].separated_by[<&nl>]>"
    - else:
        - adjust def:item "lore:<&7>You currently have <&a><server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_options.<player>.save_name]><&7> submitted! <&nl><&7>(Click to remove submission)"
    - adjust def:item flag:jug_data.type:select_save
    - define list:->:<[item]>
    - determine <[list]>
  slots:
    - [g] [g] [g] [g] [] [g] [g] [g] [g]
    - [g] [] [] [] [] [] [] [] [g]
    - [g] [] [] [] [] [] [] [] [g]
    - [g] [] [] [] [] [] [] [] [g]
    - [g] [] [g] [g] [g] [g] [g] [g] [g]
    - [g] [g] [g] [g] [] [g] [g] [g] [g]
jug_custom_settings_click:
    type: world
    debug: false
    events:
        on player clicks item_flagged:jug_data in jug_custom_settings_inv:
        - define data <context.item.flag[jug_data]>
        - define map <player.flag[juggernaut_data.map]>
        - if <player.flag[juggernaut_data.spectator].exists> && !<player.flag[juggernaut_data.is_host].exists>:
            - stop
        - if <player.flag[juggernaut_data.inventory_cooldown].exists>:
            - narrate "<&c>You are clicking too quickly!"
            - stop
        - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_set].is_truthy>:
            - narrate "<&c>The custom settings vote has ended!"
            - stop
        - choose <[data.type]>:
            - case select_save:
                - if !<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_options.<player>].exists> && <context.click> == number_key:
                    - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_options].keys.size.if_null[0]> >= 21:
                        - narrate "<&c>Sorry, but there are already the maximum number of submitted settings!"
                        - stop
                    - define save_slot <context.hotbar_button>
                    - define new_settings:<player.flag[juggernaut_settings_saves.<[save_slot]>].if_null[null]>
                    - if !<player.flag[juggernaut_settings_saves.<[save_slot]>].exists>:
                        - narrate "<&c>You have not saved settings to that save slot yet!"
                        - stop
                    - if <[new_settings.banned_kits].exists>:
                        - foreach <[new_settings.banned_kits]>:
                            - if !<proc[jug_config_read].context[kits].contains[<[value]>]>:
                                - define new_settings.banned_kits:<-:<[value]>
                                - narrate "<&c><[value]> is no longer a valid kit!"
                    - flag server juggernaut_maps.<[map]>.game_data.custom_settings_options.<player>:<[new_settings]>
                    - if !<player.flag[juggernaut_data.settings_vote].exists>:
                        - flag <player> juggernaut_data.settings_vote:<player>
                        - if !<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_votes.<player>].exists>:
                            - flag server juggernaut_maps.<[map]>.game_data.custom_settings_votes.<player>:0
                        - flag server juggernaut_maps.<[map]>.game_data.custom_settings_votes.<player>:+:1
                        - narrate "<&7>You have automatically had your vote set to your settings!"
                - else if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_options.<player>].exists>:
                    - flag server juggernaut_maps.<[map]>.game_data.custom_settings_options.<player>:!
                    - flag server juggernaut_maps.<[map]>.game_data.custom_settings_votes.<player>:!
                    - foreach <proc[jug_viewers].context[<[map]>]>:
                        - if <[value].flag[juggernaut_data.settings_vote].if_null[null]> == <player>:
                            - flag <[value]> juggernaut_data.settings_vote:!
            - case submitted_setting:
                - if <server.flag[juggernaut_maps.<[map]>.host_data.host].exists>:
                    - narrate "<&c>You can't vote for settings while the map is being hosted!"
                    - stop
                - if <player.flag[juggernaut_data.settings_vote].exists>:
                    - if <player.flag[juggernaut_data.settings_vote]> == <[data.setting]>:
                        - if <[data.setting]> == default:
                            - narrate "<&7>You removed your voted for <&e>Default <&7>settings!"
                        - else:
                            - narrate "<&7>You have removed your vote for <&a><server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_options.<[data.setting]>.save_name]><&7> settings!"
                        - flag server juggernaut_maps.<[map]>.game_data.custom_settings_votes.<player.flag[juggernaut_data.settings_vote]>:-:1
                        - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_votes.<player.flag[juggernaut_data.settings_vote]>]> <= 0:
                            - flag server juggernaut_maps.<[map]>.game_data.custom_settings_votes.<player.flag[juggernaut_data.settings_vote]>:!
                        - flag <player> juggernaut_data.settings_vote:!
                        - goto update_inventory
                    - else:
                        - flag server juggernaut_maps.<[map]>.game_data.custom_settings_votes.<player.flag[juggernaut_data.settings_vote]>:-:1
                        - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_votes.<player.flag[juggernaut_data.settings_vote]>]> <= 0:
                            - flag server juggernaut_maps.<[map]>.game_data.custom_settings_votes.<player.flag[juggernaut_data.settings_vote]>:!
                - flag <player> juggernaut_data.settings_vote:<[data.setting]>
                - if !<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_votes.<[data.setting]>].exists>:
                    - flag server juggernaut_maps.<[map]>.game_data.custom_settings_votes.<[data.setting]>:0
                - flag server juggernaut_maps.<[map]>.game_data.custom_settings_votes.<[data.setting]>:+:1
                - if <[data.setting]> == default:
                    - narrate "<&7>You voted for <&e>Default <&7>settings!"
                - else:
                    - narrate "<&7>You voted for <&a><server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_options.<[data.setting]>.save_name]><&7> settings!"
        - mark update_inventory
        - foreach <proc[jug_viewers].context[<[map]>].filter_tag[<[filter_value].open_inventory.script.name.equals[jug_custom_settings_inv].if_null[false]>].if_null[<list>]>:
            - inventory open d:jug_custom_settings_inv player:<[value]>
        - flag <player> juggernaut_data.inventory_cooldown:true
        - wait 1s
        - flag <player> juggernaut_data.inventory_cooldown:!
jug_update_custom_settings_vote:
    type: task
    definitions: map
    debug: false
    script:
    - if !<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_options.<player>].exists>:
        - stop
    - flag server juggernaut_maps.<[map]>.game_data.custom_settings_options.<player>:!
    - if <player.flag[juggernaut_data.settings_vote].exists>:
        - flag server juggernaut_maps.<[map]>.game_data.custom_settings_votes.<player.flag[juggernaut_data.settings_vote]>:-:1
    - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_votes.<player.flag[juggernaut_data.settings_vote]>]> <= 0:
        - flag server juggernaut_maps.<[map]>.game_data.custom_settings_votes.<player.flag[juggernaut_data.settings_vote]>:!
    - foreach <proc[jug_viewers].context[<[map]>].filter_tag[<[filter_value].open_inventory.script.name.equals[jug_custom_settings_inv].if_null[false]>].if_null[<list>]>:
        - inventory open d:jug_custom_settings_inv player:<[value]>
jug_custom_settings_sort:
    type: procedure
    definitions: player1|player2
    debug: false
    script:
    - define p1votes <server.flag[juggernaut_maps.<player.flag[juggernaut_data.map]>.game_data.custom_settings_votes.<[player1]>]>
    - define p2votes <server.flag[juggernaut_maps.<player.flag[juggernaut_data.map]>.game_data.custom_settings_votes.<[player2]>]>
    - if <[p1votes]> > <[p2votes]>:
        - determine -1
    - else if <[p1votes]> < <[p2votes]>:
        - determine 1
    - else:
        - determine 0
jug_custom_settings_top:
    type: procedure
    definitions: map
    debug: false
    script:
    - if !<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_votes].exists>:
        - determine none
    - define def1 <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_votes].keys.sort[jug_custom_settings_sort]>
    - define ovr_votes 0
    - foreach <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_votes].exclude[default].if_null[<list>]>:
        - define ovr_votes:+:<[value]>
    - if <[ovr_votes]> > <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size.div[2]>:
        - define def1firstvotes <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_votes.<[def1].first>]>
        - define def2 <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_votes].keys.filter_tag[<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_votes.<[filter_value]>].is_more_than_or_equal_to[<[def1firstvotes]>]>]>
        - if <[def2].contains[default]>:
            - determine default
        - else:
            - determine <[def2]>
    - else:
        - determine none
jug_custom_settings_top_display:
    type: procedure
    definitions: map|length
    debug: false
    script:
    - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_options].keys.size.if_null[0]> <= 0:
        - determine "<&e>No Settings Submitted"
    - if !<[length].exists>:
        - define length long
    - if !<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_set].is_truthy>:
        - define list <proc[jug_custom_settings_top].context[<[map]>]>
        - if <[list].size.exists>:
            - if <[list].size> >= 2 && <[length]> == short:
                - define players <[list].parse_tag[<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_options.<[parse_value]>.save_name]>].first>,<&sp>...
            - else:
                - define players <[list].parse_tag[<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_options.<[parse_value]>.save_name]>].comma_separated>
        - else:
            - if <[list]> != default && <[list]> != none:
                - define players <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_options.<[list]>.save_name]>
            - else:
                - define players <[list]>
        - choose <[players]>:
            - case default:
                - determine "<&e>Default Settings <&7>(<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_votes.default]> Vote<proc[jug_plural_s].context[<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_votes.default]>]>)"
            - case none:
                - define ovr_votes 0
                - foreach <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_votes].exclude[default].if_null[<list>]>:
                    - define ovr_votes:+:<[value]>
                - if <[length]> == long:
                    - determine "<&e>N/A <&nl><&7>More than half of the players must vote for custom settings <&nl><&7>for them to be used. (<[ovr_votes]>/<server.flag[juggernaut_maps.<[map]>.game_data.players].keys.size.div[2].add[1].round_down.if_null[1]> Votes Required)"
                - else if <[length]> == short:
                    - determine "<&e>Not Enough Votes"
            - default:
                - determine "<&e><[players]> <&7>(<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_votes.<[list].first>]> Vote<proc[jug_plural_s].context[<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_votes.<[list].first>]>]>)"
    - else:
        - if <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings].exists>:
            - determine "<&e><server.flag[juggernaut_maps.<[map]>.game_data.custom_settings.save_name]> <&a><&l>✓"
        - else:
            - determine "<&e>None <&a><&l>✓"
jug_apply_custom_settings:
    type: task
    definitions: map
    debug: false
    script:
    - flag server juggernaut_maps.<[map]>.game_data.custom_settings_set:true
    - define list <proc[jug_custom_settings_top].context[<[map]>]>
    - if <[list].size.exists>:
        - define top <[list].random>
    - else:
        - define top <[list]>
    - choose <[top]>:
        - case default:
            - narrate "<&7>The custom settings vote had ended! <&a>Default<&7> settings have been selected!" targets:<proc[jug_viewers].context[<[map]>]>
        - case none:
            - narrate "<&7>The custom settings vote had ended! <&7>Not enough players voted!" targets:<proc[jug_viewers].context[<[map]>]>
        - default:
            - flag server juggernaut_maps.<[map]>.game_data.custom_settings:<server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_options.<[top]>]>
            - narrate "<&7>The custom settings vote had ended! <&a><server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_options.<[top]>.save_name]><&7> settings have been selected!" targets:<proc[jug_viewers].context[<[map]>]>
            - define random_status:false
            - define new_settings <server.flag[juggernaut_maps.<[map]>.game_data.custom_settings_options.<[top]>]>
            - foreach <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.if_null[<list>]>:
                - if <[value].flag[juggernaut_data.kit].exists> && <player.flag[juggernaut_custom_settings.random_only].exists>:
                    - flag <[value]> juggernaut_data.kit:!
                - if <[random_status]> && !<[new_settings.random_only].exists>:
                    - narrate "<&c>Random Only has been disabled, which means you can now pick your kit!" targets:<[value]>
                - else if !<[random_status]> && <[new_settings.random_only].exists>:
                    - narrate "<&c>Random Only has been enabled, which means your kit selection has been reset!" targets:<[value]>
                - if <player.flag[juggernaut_custom_settings.banned_kits].if_null[<list>].contains[<[value].flag[juggernaut_data.kit].if_null[null]>]>:
                    - narrate "<&c>The kit you had selected has been disabled! You have been reset back to using a random kit." targets:<[value]>
                    - flag <[value]> juggernaut_data.kit:!
                - if <[value].flag[juggernaut_data.kit].exists>:
                    - inventory set d:<[value].inventory> o:<proc[jug_config_read].context[kits.<[value].flag[juggernaut_data.kit]>.gui_item]>[display_name=<&7>Selected<&sp>Kit:<&sp><&color[#<proc[jug_config_read].context[kits.<[value].flag[juggernaut_data.kit]>.primary_color]>]><&l><proc[jug_config_read].context[kits.<[value].flag[juggernaut_data.kit]>.display_name]>] slot:5
                - else:
                    - inventory set d:<[value].inventory> o:FIREWORK_STAR[display_name=<&7>Selected<&sp>Kit:<&sp><&l>Random] slot:5
                - foreach <server.flag[juggernaut_maps.<[map]>.game_data.players].keys.filter_tag[<[filter_value].open_inventory.script.name.equals[jug_kit_selection_gui].if_null[false]>].if_null[<list>]>:
                    - inventory open d:jug_kit_selection_gui player:<[value]>
jug_kit_armor_proc:
    type: procedure
    definitions: amount|type
    debug: false
    script:
    - if <[amount]> >= 12:
        - determine netherite_<[type]>
    - else if <[amount]> >= 9:
        - determine diamond_<[type]>
    - else if <[amount]> >= 7:
        - determine iron_<[type]>
    - else if <[amount]> >= 4:
        - determine chainmail_<[type]>
    - else if <[amount]> >= 0:
        - determine leather_<[type]>
jug_juggernaut_slowness:
    type: task
    definitions: map
    debug: false
    script:
    - define life_id <player.flag[juggernaut_data.life_id].if_null[1]>
    - repeat 5:
        - wait 30s
        - if <player.has_flag[juggernaut_data.in_game]> && <[life_id]> == <player.flag[juggernaut_data.life_id].if_null[0]>:
            - definemap attributes:
                generic_movement_speed:
                    1:
                        operation: ADD_SCALAR
                        amount: -0.1
                        id: <util.random.uuid>
            - inventory adjust d:<player> slot:37 add_attribute_modifiers:<[attributes]>
            - narrate "<&7>You have been slowed by being the juggernaut! You now move <&c><[value].mul[10]><&chr[0025]> <&7>slower!"
jug_particle_bubble:
    type: task
    debug: false
    definitions: type|distance|mod
    script:
    - define baseLoc <player.location.add[0,0.95,0]>
    - repeat 15 as:pitch:
        - repeat 30 as:yaw:
            - define Loc <[baseLoc].with_yaw[<element[0].add[<[yaw].sub[1].mul[12]>]>].with_pitch[<element[90].sub[<[pitch].sub[1].mul[12]>]>].forward[<[distance]>]>
            - define ran <util.random_decimal>
            - choose <[type]>:
                - case mage:
                    - if <[ran]> > 0.92:
                        - define color #ff9922
                    - else if <[ran]> > 0.8:
                        - define color #ff7700
                    - else if <[ran]> > 0.65:
                        - define color #888888
                    - else if <[ran]> > 0.4:
                        - define color #444444
                    - else:
                        - define color #000000
                - case tank_on:
                    - if <[ran]> > 0.75:
                        - define color #999999
                    - else:
                        - define color #8888aa
                - case tank_off:
                    - if <[ran]> > 0.75:
                        - define color #777799
                    - else:
                        - define color #777777
                - case berserker_on:
                    - if <[ran]> > 0.9:
                        - define color #8888aa
                    - else if <[ran]> > 0.75:
                        - define color #ff4444
                    - else if <[ran]> > 0.5:
                        - define color #bb0000
                    - else:
                        - define color #ff0000
                - case berserker_off:
                    - if <[ran]> > 0.9:
                        - define color #dd7777
                    - else if <[ran]> > 0.75:
                        - define color #bb7777
                    - else if <[ran]> > 0.5:
                        - define color #997777
                    - else:
                        - define color #777777
                - case samurai_on:
                    - if <[ran]> > 0.7:
                        - define color #cc3333
                    - else if <[ran]> > 0.5:
                        - define color #ff0000
                    - else if <[ran]> > 0.3:
                        - define color #bbbb22
                    - else:
                        - define color #ffff00
                - case samurai_off:
                    - if <[ran]> > 0.7:
                        - define color #773333
                    - else if <[ran]> > 0.5:
                        - define color #770000
                    - else if <[ran]> > 0.3:
                        - define color #777722
                    - else:
                        - define color #777700
            - choose <[mod].if_null[null]>:
                - case inward:
                    - define vel <[baseLoc].sub[<[loc]>].x>,<[baseLoc].sub[<[loc]>].y>,<[baseLoc].sub[<[loc]>].z>
                - case outward:
                    - define vel <[loc].sub[<[baseLoc]>].x.mul[100]>,<[loc].sub[<[baseLoc]>].y.mul[100]>,<[loc].sub[<[baseLoc]>].z.mul[100]>
                - default:
                    - define vel 0,0,0
            - playeffect effect:redstone special_data:1|<[color]> at:<[loc]> quantity:1 offset:0,0,0 velocity:<[vel]> visibility:200
jug_plural_s:
    type: procedure
    definitions: value
    debug: false
    script:
    - if <[value]> != 1:
        - determine s
    - else:
        - determine <element[]>
jug_kit_display:
    type: task
    debug: false
    definitions: action
    script:
    - choose <[action]>:
        - case create:
            - if <player.has_flag[juggernaut_data.kit_display_stand]>:
                - narrate "<&c>ERROR: You already have a kit display stand."
                - stop
            - if <player.has_flag[juggernaut_data.is_juggernaut]>:
                - define mod <&c><&l>⚑<&sp>
            - define kit <&color[#<proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.primary_color]>]><proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.display_name]>
            - define health <player.health.round>
            - define display "<[mod].if_null[]><[kit]> <&c><[health]>♥"
            - spawn armor_stand[visible=false;custom_name=<[display]>;custom_name_visible=true;marker=true;hide_from_players=true] save:kit_display
            - flag <player> juggernaut_data.kit_display_stand:<entry[kit_display].spawned_entity>
            - attach <entry[kit_display].spawned_entity> to:<player> offset:0,2,0 sync_server
            - flag <entry[kit_display].spawned_entity> jug_kit_display:true
            - wait 2t
            - adjust <player> hide_entity:<entry[kit_display].spawned_entity>
            - adjust <entry[kit_display].spawned_entity> show_to_players
        - case update:
            - if <player.flag[juggernaut_data.kit_display_stand].exists>:
                - define stand <player.flag[juggernaut_data.kit_display_stand]>
                - if <player.has_flag[juggernaut_data.is_juggernaut]>:
                    - define mod <&c><&l>⚑<&sp>
                - define kit <&color[#<proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.primary_color]>]><proc[jug_config_read].context[kits.<player.flag[juggernaut_data.kit]>.display_name]>
                - define health <player.health.round>
                - define display "<[mod].if_null[]><[kit]> <&c><[health]>❤"
                - adjust <[stand]> custom_name:<[display]>
        - case remove:
            - if <player.flag[juggernaut_data.kit_display_stand].exists>:
                - define stands <player.flag[juggernaut_data.kit_display_stand]>
                - remove <[stands]>
                - flag player juggernaut_data.kit_display_stand:!
        - case sneak:
            - if <player.flag[juggernaut_data.kit_display_stand].exists>:
                - define stand <player.flag[juggernaut_data.kit_display_stand]>
                - sneak <[stand]> fake
                - attach <[stand]> to:<player> offset:0,1.585,0 sync_server
        - case unsneak:
            - if <player.flag[juggernaut_data.kit_display_stand].exists>:
                - define stand <player.flag[juggernaut_data.kit_display_stand]>
                - sneak <[stand]> stopfake
                - attach <[stand]> to:<player> offset:0,2,0 sync_server
jug_display_sneak:
    type: world
    debug: false
    events:
        on player flagged:juggernaut_data.in_game toggles sneaking:
        - if <context.state>:
            - run jug_kit_display def:sneak
        - else:
            - run jug_kit_display def:unsneak
jug_healer_particles:
    type: task
    debug: false
    definitions: abilities
    script:
    - define angle 0
    - if <player.has_flag[juggernaut_data.is_juggernaut]>:
        - define player_type juggernaut
    - else:
        - define player_type player
    - define rad <[abilities.circle_radius.<[player_type]>].if_null[<[abilities.circle_radius]>]>
    - define dur <[abilities.circle_duration.<[player_type]>].if_null[<[abilities.circle_duration]>]>
    - define freq <[abilities.circle_frequency.<[player_type]>].if_null[<[abilities.circle_frequency]>]>
    - define loc <player.location>
    - repeat <[dur].mul[20]>:
        - define act:+:1
        - repeat 5:
            - playeffect effect:VILLAGER_HAPPY at:<[loc].with_yaw[<[angle]>].with_pitch[0].add[0,0.5,0].forward[<[rad]>]> quantity:1 offset:0,0,0 visibility:200
            - if <[player_type]> == juggernaut:
                - playeffect effect:REDSTONE special_data:1|red at:<[loc].with_yaw[<[angle]>].with_pitch[0].add[0,0.5,0].forward[<[rad].sub[0.2]>]> quantity:1 offset:0,0,0 visibility:200
            - else:
                - playeffect effect:REDSTONE special_data:1|white at:<[loc].with_yaw[<[angle]>].with_pitch[0].add[0,0.5,0].forward[<[rad].sub[0.2]>]> quantity:1 offset:0,0,0 visibility:200
            - define angle:+:4
            - if <[act].div[20]> >= <[freq]>:
                - repeat 18:
                    - playeffect effect:HEART at:<[loc].with_yaw[<[angle]>].with_pitch[0].add[0,0.5,0].forward[<[rad]>]> quantity:1 offset:0,0,0 visibility:200
                    - define angle:+:20
                - if <[loc].find_players_within[<[rad]>].shared_contents[<proc[jug_allies_proc].context[alive]>].size> > 0:
                    - define players <[loc].find_players_within[<[rad]>].shared_contents[<proc[jug_allies_proc].context[alive]>]>
                    - heal 1 <[players]>
                - define act:0
        - wait 1t
jug_item_description:
    type: procedure
    definitions: kit|item_number
    debug: false
    script:
    - define kit_root <proc[jug_config_read].context[kits.<[kit]>]>
    - define lore <list[]>
    - choose <[item_number]>:
        - case armor:
            - if <[kit_root.armor].exists>:
                - define "lore:->:<&e>Armor: <&a><[kit_root.armor]>"
            - if <[kit_root.armor_tougness].exists>:
                - define "lore:->:<&e>Armor Toughness: <&a><[kit_root.armor_toughness]>"
            - if <[kit_root.speed].exists>:
                - define "lore:->:<&e>Movement Speed: <&a><[kit_root.speed]>"
        - default:
            - if <[kit_root.inventory.<[item_number]>].exists>:
                - define item_root <[kit_root.inventory.<[item_number]>]>
                - if <[item_root.attack_damage].exists>:
                    - define lore:->:<&e>Attack<&sp>Damage:<&sp><&a><[item_root.attack_damage]>
                - if <[item_root.attack_speed].exists>:
                    - define lore:->:<&e>Attack<&sp>Speed:<&sp><&a><[item_root.attack_speed]>
                - if <[item_root.projectile_damage].exists>:
                    - define lore:->:<&e>Projectile<&sp>Damage:<&sp><&a><[item_root.projectile_damage]>
                - if <[item_root.magic_damage].exists>:
                    - define lore:->:<&e>Magic<&sp>Damage:<&sp><&a><[item_root.magic_damage]>
                - if <[item_root.magic_range].exists>:
                    - define lore:->:<&e>Magic<&sp>Range:<&sp><&a><[item_root.magic_range]>
                - if <[item_root.magic_speed].exists>:
                    - define lore:->:<&e>Magic<&sp>Speed:<&sp><&a><[item_root.magic_speed]>
                - if <[item_root.ability].exists>:
                    - define lore:->:<&e>Ability:<&sp><&a><[item_root.ability.display_name]>
                    - define lore:->:<&sp><&7>-<&sp><&6>Description:<&sp><&7><[item_root.ability.description].split_lines_by_width[250].replace[<&nl>].with[<&nl><&sp><&7>]>
                    - foreach <[item_root.ability.description_stats]>:
                        - if <[item_root.ability.<[value]>.player].exists> || <[item_root.ability.<[value]>.juggernaut].exists>:
                            - define lore:->:<&sp><&7>-<&sp><&6><[key]>:<&sp><&f><[item_root.ability.<[value]>.player].if_null[<[item_root.ability.<[value]>]>]><&7>/<&c><[item_root.ability.<[value]>.juggernaut].if_null[<[item_root.ability.<[value]>]>]>
                        - else:
                            - define lore:->:<&sp><&7>-<&sp><&6><[key]>:<&sp><&a><[item_root.ability.<[value]>]>
    - determine <[lore]>
jug_kit_display_remove:
    type: world
    debug: false
    events:
        after entity_flagged:jug_kit_display added to world:
        - remove <context.entity>