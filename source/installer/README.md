# Riptide installer
Make installing riptide a breeze :)

## Supported OS
- openSUSE
- Arch
- Ubuntu

## Prerequisites
Ubuntuusers: You need curl... install curl! `sudo apt install curl`

## Usage
```bash
curl http://the-url.bla/(opensuse|arch|ubuntu).sh | bash
```

## Testing
- fire up a vm
- Start http-server `npm start`
```bash
curl http://HOST_MACHINE_IP:PORT/(opensuse|arch|ubuntu).sh | URL=http://HOST_MACHINE_IP:PORT bash
```