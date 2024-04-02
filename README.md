# Modeling Portfolio

My Modeling Portfolio @ [caseybrigid.github.io](https://caseybrigid.github.io)

## Adding Totally New Images to Portfolio
1. Add new images to a folder called new in this directory
2. Run `bash ./src/update.sh`
3. `cd src && npm run dev` to check out the changes @ "http://localhost:5173", go to /edit to move stuff around, save & replace `description.json` into /src/portfolio/public
4. Re-compile and upload to github 
```bash
cd src; npm install; npm run build
git add .
git commit -m "updated portfolio pictures"
git push
```

## Copying this site as a template?
If you'd like to use this site as a template, be sure to change the base address in the src/package.json build script, it makes this type of website (SPA's) work on github

## Development Dependencies
- [nodejs](https://nodejs.org/en)
- [ffmpeg](https://ffmpeg.org/)
- [vscode](https://code.visualstudio.com/download) (optional)

## Resources
- [Converting image formats for large images on websites](https://stackoverflow.com/questions/40127266/change-jpeg-into-progressive-jpeg-image)
- [images](https://cloudinary.com/blog/progressive_jpegs_and_green_martians)
- [vue image loaded directive](https://stackoverflow.com/questions/47984004/vuejs-2-how-to-detect-img-complete-property/50931942#comment136735840_50931942)


