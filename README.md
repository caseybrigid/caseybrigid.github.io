# Modeling Portfolio

My Modeling Portfolio @ [caseybrigid.github.io](https://caseybrigid.github.io)

## Adding Images to Portfolio
1. Compress images for website before upload, this can be done using`compress.sh <infolder> <outfolder>`, filenames require format `<name>.JPG`
2. Add new photos by placing them in `src/public/<foldername>`, add the name and photo credits to [src/public/portfolio/description.json](src/public/portfolio/description.json) in then order it should appear on the portfolio
3. re-compile and upload to github

## Todo
- [x] Automate column/image placement in Portfolio
- [x] Add photo credit overlay support
- [x] Make update/reorder process for images (column major)

## Copying this site as a template?
If you'd like to use this site as a template, be sure to change the base address in the src/package.json build script, it makes this type of website (SPA's) work on github

## Development Dependencies
- [nodejs](https://nodejs.org/en)
- [ffmpeg](https://ffmpeg.org/)
- [vscode](https://code.visualstudio.com/download) (optional)




