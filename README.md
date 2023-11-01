# Modeling Portfolio

My Modeling Portfolio @ [caseybrigid.github.io](https://caseybrigid.github.io)

## Adding Images to Portfolio
1. Compress images for website before upload, this can be done using`compress.sh <infolder> src/public/portfolio`, filenames require the format `<name>.JPG`
2. Add name and photo credits to [src/public/portfolio/description.json](src/public/portfolio/description.json) in then order it should appear on the portfolio
3. Re-compile and upload to github 
```bash
cd src; npm install; npm run build
git add .
git commit -m "updated portfolio pictures"
git push
```

## Todo
- [ ] Make app for editing portfolio page
    - [ ] Upload images through drag and drop this will automatically compress the img and add it to the portfolio folder
    - [ ] Reorder list of images side view, with option to delete images | next to preview of main page
    - [ ] Save button, that saves the new description.json to the portfolio folder, rebuilds the website and uploads it to github (git pull on startup)
        - Requires github ssh key
- [ ] Avoid Scanning Of Loading Images
- [x] Automate column/image placement in Portfolio
- [x] Add photo credit overlay support
- [x] Make update/reorder process for images (column major)


## Copying this site as a template?
If you'd like to use this site as a template, be sure to change the base address in the src/package.json build script, it makes this type of website (SPA's) work on github

## Development Dependencies
- [nodejs](https://nodejs.org/en)
- [ffmpeg](https://ffmpeg.org/)
- [vscode](https://code.visualstudio.com/download) (optional)




