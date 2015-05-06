# Prosody in Docker #

This Docker image with prosody is built ontop the basic Ubuntu image.
The community module repository of prosody is included.


## Running ##

```bash
docker run -d --name prosody -p 5222:5222 -p 5269:5269 <tag>
```

## Ports ##

This image exposes the following ports to the docker host:

* __5222__
* __5269__

## Volumes ##

* __/etc/prosody/__:
    - Configuration file `prosody.cfg.lua`
    - SSL Certificates for your virtual hosts
* __/var/lib/prosody__:
    - this is where the users are stored

## Configuration File ##

The configuration file `prosody.cfg.lua` needs to include the following lines:
```lua
pidfile = "/run/prosody/prosody.pid" -- prosody doesn't start when it can't write to the directory
deamonize = false;
log = {
    info = "*console"; -- change to debug for more information
    error = "*console";
}
plugin_paths = { "/usr/lib/prosody-modules" } -- allows to enable community plugins
```

optional:
```lua
modules_enabled = {
    "smacks";   -- XEP-0198: Stream Management
    "carbons";  -- XEP-0280: Message Carbons
}
```

and of course your virtual host section.