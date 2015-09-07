#!/bin/bash
ln -vsf $PWD/init.el ~/.emacs
mkdir -vp ~/.emacs.d
ln -vsf $PWD/emacs.d/custom.el ~/.emacs.d/custom.el
mkdir -vp ~/.emacs.d/modules
ln -vsf $PWD/emacs.d/modules/bind-key.el ~/.emacs.d/modules/bind-key.el
ln -vsf $PWD/emacs.d/modules/use-package.el ~/.emacs.d/modules/use-package.el
