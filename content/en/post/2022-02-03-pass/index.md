---
title: "`Pass` for password management"
author: 'Nikita Gusarov'
date: '2022-02-03'
slug: []
categories: [Programming, Security]
tags: [Programming, Security, Password management, Linux]
featured_image: '/images/pass-0.png'
description: ''
---



Some days ago I've descried my new password management model, where I've mentioned a tool named [`pass`](https://www.passwordstore.org/). 
By the end of the year 2021 I've been using this tool for some time for my passwords management, while in 2022 it became more of a fallback measure for my backups and secure password storage. 
Today I'll discuss some of the features of this tool, as well as my personal setup and use-case. 

## [`Pass`](https://www.passwordstore.org/)

What is [`pass`](https://www.passwordstore.org/)? 
Pass is the simple and yet extremely powerful CLI password manager for Linux (there exists a [client for Windows (Pass4Win)](https://github.com/mbos/Pass4Win#readme) as well). 
It has all the essential features of a password manager, while being easily accessible through a command line. 
The last feature makes it extremely useful when one want to integrate the password manager with personalised scripts. 
Now let's focus on some of its features. 

Firstly, `pass` is secure (or at least it provides sufficient level of secrecy, considering you make confidence to the [OpenPGP](https://www.openpgp.org/) encryption). 
Each password is stored in a separate [`gpg`](https://gnupg.org/) encrypted file. 
For those who are not fully familiar with different abbreviations, `gpg` stands for *GnuPG*:

> GnuPG is a complete and free implementation of the [OpenPGP](https://www.openpgp.org/) standard as defined by [RFC4880](https://datatracker.ietf.org/doc/html/rfc4880) (also known as PGP - Pretty Good Privacy). 
> GnuPG allows you to encrypt and sign your data and communications; 
> it features a versatile key management system, along with access modules for all kinds of public key directories. 
> GnuPG, also known as GPG, is a command line tool with features for easy integration with other applications. 

Secondly, the `pass` is *modular software*. 
There exist numerous extensions, which provide complementary features and alternative interfaces (GUI clients). 
The wide popularity makes it easily accessible on all of the Linux distributions, as well as Windows, OS X, iOS and Android. 
Most popular browsers (Firefox and Chrome) are equally provided with the integration extensions. 

Finally, the convenient integration with your filesystem makes it possible to use the resulting database as one wishes. 
In fact, `pass` stores all the passwords inside a single folder (of your choice, with default being `~/.password-store`). 
This allows you to synchronise this folder with a cloud storage or copy it to a USB to have a portable vault. 
Moreover, the organisation under folder format makes it easy to use such features as `git` integration or `tomb` encryption of an entire folder, but will speak about it later. 

## Setting up `pass`

Most Linux distribution have `pass` available in the default repositories, which makes installation straightforward:

```
sudo apt update && sudo apt install pass
```

The next step is the generation of GPG key for password encryption, which assumes you have already installed `gpg` (or `gpg2`):

```
gpg --gen-key
```

This simple function requires you to simply follow the instructions and select the desired key's type, length, expiration time, name and email. 
The key name (id, label) will be then used to identify the key for our password database encryption. 
Keep in mind, that it's possible to specify several keys at once for a single password storage in order to encrypt each password with multiple ids.
Theoretically, on this point one can directly proceed with password storage generation, but we would rather install some of supplementary modules: [`pass-tomb`](https://github.com/roddhjav/pass-tomb#readme) in particular. 

[`Tomb`](https://www.dyne.org/software/tomb/) is an open source system for file encryption on GNU/Linux, facilitating the backup of secret files. 
It allows us to generate encrypted storage folders, which may be opened and closed only using associated key-files. 
Last ones being also protected with a password chosen by the user. 
As you have seen, `pass` encrypts only the text files inside a folder, so it's a good idea to encrypt the whole folder as well to hide its structure and contents completely. 
The `pass-tomb` extension will use the same GPG key to encrypt passwords and tomb. 
On Debian based distribution for installation run:

```
sudo apt install tomb pass-extension-tomb
```

Once the required packages installed we can initialise the storage with command:

```
pass tomb <gpg-id>
```

Personally I prefer to keep my password storage on a separate USB stick for security reasons. 
This way I may ensure that `.password-storage.tomb` file and corresponding `.tomb` key-file are stored on two independent devices. 
The key-file may be then propagated across a number of trusted devices, while a single encrypted `.password-storage.tomb` may be easily portable on a USB drive. 
It's advices to make separate backups of those two files and store them in different locations. 
To do so we may directly specify desired folder location during the initiation stage:

```
pass tomb -p <path-to-folder> <gpg-id>
```

Or place the resulting `.password-storage.tomb` file on a USB drive by hand and create a symbolic link. 
However, the first approach is preferred because it's supposed to be more stable. 

## Usage

Even though on the first stages I've used the `pass` as my main password manager, which replaced a single plain text encrypted file, I've decided to use it as my fallback solution. 
Why such decision? 
Mostly my choice was influenced by appearance of the OnlyKey in my possession, as well as the decision to test the [Vaultwarden](https://github.com/dani-garcia/vaultwarden) as my password manager. 
Frankly it's more handy to have the password database synchronised over the web (even though less secure), but as I've not enough confidence in the persistence of my current server solution I definitely needed some fallback plan. 
An encrypted `pass-tomb` was one of the best choices, because I've already my database complete and working. 
This lead to a previously described security framework comprising: 

- [OnlyKey](https://onlykey.io/) hardware password manager for the most sensitive passwords and 2FA (FIDO2, OTP, etc)
- [Vaultwarden](https://github.com/dani-garcia/vaultwarden) self-hosted cloud password storage for non-sensitive passwords
- `Pass-tomb` on a USB unifying all the credentials as a fallback solution (stored in a secure location for now)