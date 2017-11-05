include config

ok directory "${HOME}/.local/bin"
for file in "${dotfiles}/bin/"*; do
    ok symlink "${HOME}/.local/bin/$(basename ${file})" "${file}"
done
