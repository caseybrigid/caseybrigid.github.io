# Modeling Portfolio

My Modeling Portfolio @ [caseybrigid.github.io](https://caseybrigid.github.io)

## Adding Images to Portfolio
1. Compress images for website before upload, this can be done using`compress.sh <infolder> <outfolder>`
2. Add new photos by placing them in `src/public/<foldername>`, naming them `<number>.JPG`, the number will change the order in the website, add photo credits in /src/public/portfolio/description.json
3. re-compile and upload to github

## Todo
- [ ] Automate column/image placement in Portfolio
- [ ] Add photo credit overlay support
- [ ] Make easy update/reorder process for images (row major)

## Copying this site as a template?
If you'd like to use this site as a template, be sure to change the base address in the src/package.json build script, it makes this type of website (SPA's) work on github

## Development Depencies
- [nodejs](https://nodejs.org/en)
- [ffmpeg](https://ffmpeg.org/)
- [vscode](https://code.visualstudio.com/download) (optional)




