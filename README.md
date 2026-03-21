# Team Fortress 2 Classified Dedicated Server in Docker

*Team Fortress 2 Classified* (previously Team Fortress 2 Classic) is a modification of Team Fortress 2, developed by
[EMINOMA](https://store.steampowered.com/developer/EMINOMA). Defining itself as a "re-imagining of the 2008-2009 era of
the original Team Fortress 2", it restores the character shading of the game's beta, reimplements cut content, removes
many later additions to the game’s content and lore, and adds new content intended to evoke the spirit of older updates
to the game. Notable content additions include two additional teams, Green (GRN) and Yellow (YLW) which can be used by
mappers to modify existing game modes, and an escort game mode based on the scrapped "Civilian" class.

![TF2 Classified Banner](https://raw.githubusercontent.com/LacledesLAN/gamesvr-tf2classified/master/Documentation/images/tf2classified_banner00.jpg "TF2 Classified Banner")

This repository is maintained by [Laclede's LAN](https://lacledeslan.com). Its contents are intended to be bare-bones
and used as a stock server. For examples of building a customized server from this Docker image browse its related
child-projects [gamesvr-tf2classified-freeplay](https://github.com/LacledesLAN/gamesvr-tf2classified-freeplay). If any
documentation is unclear or it has any issues please see [CONTRIBUTING.md](./CONTRIBUTING.md).

## Linux x64 (64-bit)

### Run simple interactive server

```shell
docker run -it --rm --net=host lacledeslan/gamesvr-tf2classified ./srcds_run_64 -game tf2classified -tf_path /app/tf2 +map 4arena_floodgate;
```

## Run self-tests

```shell
docker run -it --rm --net=host lacledeslan/gamesvr-tf2classified ./ll-tests/gamesvr-tf2classified.sh
```

## Getting Started with Game Servers in Docker

[Docker](https://docs.docker.com/) is an open-source project that bundles applications into lightweight, portable,
self-sufficient containers. For a crash course on running Dockerized game servers check out [Using Docker for Game
Servers](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/DockerAndGameServers.md). For tips, tricks,
and recommended tools for working with Laclede's LAN Dockerized game server repos see the guide for [Working with our
Game Server Repos](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/WorkingWithOurRepos.md). You can
also browse all of our other Dockerized game servers: [Laclede's LAN Game Servers
Directory](https://github.com/LacledesLAN/README.1ST/tree/master/GameServers).
