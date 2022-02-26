---
title: OnlyKey for Linux login
author: 'Nikita Gusarov'
date: '2022-01-29'
slug: []
categories: [Programming]
tags: [Programming, OnlyKey, Linux, Login]
featured_image: '/images/onlykey_auth.png'
description: ''
---



After receiving a hardware authentication token for the *New Year*, I've spent quite a lot of time on the configuration. 
Even though I'd already modified my security model by the end of 2021, I needed to reconsider it once again. 
Now my password management framework comprises three elements: 

1. Hardware security token (*OnlyKey*) for most sensitive credentials and 2FA (two facto authentication like OTP, FIDO2 / U2F)
2. Self-hosted cloud storage (*Vaultwarden*) for less sensitive credential
3. Encrypted password database (*Pass-Tomb*) on a USB 

Each of these elements requires a separate post, but for now I'll focus only on the first part. 
What is more, I'll separate the content into several parts: in this particular part I'll describe how it's possible to configure the *OnlyKey* as second factor authentication for Linux system login (or `sudo`).



## [OnlyKey](https://onlykey.io/)

There exist quite a lot of different hardware password managers available on the market. 
Among the most popular ones we may find: 

- [YubiKey](https://www.yubico.com/), which is mostly popular for enterprise solutions, but is not *Open Source*
- [NitroKey](https://www.nitrokey.com/), which is *Open Source* and backed up by the privacy oriented community
- [SoloKey](https://solokeys.com/) - a crowdfunded *OpenSource* substitution for YubiKey
- [OnlyKey](https://onlykey.io/), that is not only *OpenSource*, but provides an additional level of hardening with a PIN code

As I've got my *OnlyKey* as a gift I cannot describe the choice procedure itself, but I can describe some of the advantages over the other hardware tokens. 
All of the listed above models require physical presence of the owner in order to use the key, this is achieved through an interactive button inbuilt into the device. 
However, the devices themselves are rarely protected by any additional security layer, it is usually assumed that the owner keeps the device safe enough (or uses some sort of application to protect it from unauthorised access). 
The *OnlyKey* creators mitigated this problem using a completely different approach: they have inbuilt an interactive 6-digit keyboard into the device. 
In order to unlock the device one will have to provide a 7 to 10 digit PIN using the inbuilt keyboard. 
It's even possible to configure self destruction of the data after several erroneous attempts. 

What is more, the *OnlyKey* is *Open Source* and has a developing community with features added even now. 
Nevertheless, the community support is still limited and some features require additional steps for proper configuration. 
Sometimes it's even necessary to search for solutions in the documentation of the competing solutions (the websites of *YubiKey* and *NitroKey* are usually a good source for information). 



## Hardware token for Linux login

But lets not stay too long on the description of the *OnlyKey* features and go directly to the main topic. 
As I've mentioned, the software of *OnlyKey* lacks some interesting features for configuration. 
The ability to use the key as a second factor for Linux system login is among those missing features, which require some time to set them up. 

In order to enable 2FA (U2F in this case) for Linux system login we will have to use the library supported by *Yubico* (the *YubiKey* creators). 
Here I speak about [Pluggable Authentication Module (PAM) Universal 2nd Factor (U2F)](https://github.com/Yubico/pam-u2f), which is already available in most Debian based distros as `libpam-u2f`. 
Most of the information used this post was pulled from [here](https://github.com/trustcrypto/OnlyKey-Firmware/issues/63).

> Before proceeding it is a good idea to create a recovery user with root privileges, because if something is going to go wrong you will find yourself unable to login or locked out of root acces.

Assuming, you have already created a full backup of the system, as well as created a fallback administrator user, we may proceed with system configuration. 
The command to add the *OnlyKey* as recognised U2F tokens is: 

```
pamu2fcfg -u <your user>
```

You will then be asked to provide a correct PIN for U2F device (if one was configured) and to tap your device, while it flashes blue. 

By default `pam-u2f` will look for the corresponding key in `~/.config/Yubico/u2f_keys` file. 
You'll need to create one and write the corresponding key inside:

```
mkdir -p ~/.config/Yubico
pamu2fcfg -u <your user> > ~/.config/Yubico/u2f_keys
```

Once the keys configured, it is necessary to create corresponding PAM rules following your needs. 
We may imagine creating two PAM rules: (1) a strong one, prompting for both U2F and password authentication, and (2) a weak one, requiring only U2F token. 
For example: 

```
sudo echo "auth required pam_u2f.so nullok cue interactive" > /etc/pam.d/u2f-strong
```

and

```
sudo echo "auth sufficient pam_u2f.so nullok cue interactive" > /etc/pam.d/u2f-weak
```

Finally, we can use these PAM rules to modify the existing system configuration. 
For example, I've preferred to configure a password-less `sudo` on my personal machine in order not to retype my password on every occasion. 
To do so, I've added `auth include u2f-weak` to `/etc/pam.d/sudo` file. 

> Because all the above configuration already requires `sudo` privileges for set-up, it is a good idea to benefit from it for tests in case of miss-configuration. 
> Just open a new terminal session and attempt to use something with `sudo` (ex: `sudo ls`).