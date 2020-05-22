#### Packer

![packer](https://www.datocms-assets.com/2885/1588887894-packerprimarylogofullcolorrgb.svg)

 - https://www.packer.io/
 - https://www.packer.io/docs/builders/vmware/iso/
 - https://help.ubuntu.com/community/Installation/MinimalCD

Some builds will require a Berkshelf vendored package

```
chef exec berks package docker.tar.gz --berksfile=ubuntu_18_lts_docker/Berksfile
```
