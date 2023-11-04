<template>
  <!-- Reference https://www.w3schools.com/howto/tryit.asp?filename=tryhow_css_image_grid_responsive -->
  <!-- Reference https://imagekit.io/blog/lazy-loading-images-complete-guide/ -->
    <div class="grid-container">
      <div v-for="group in images" class="grid-item">
        <Transition v-for="name in group">
          <div v-if="show" class="image-container">
            <img 
                alt="" class="lazy"
                :src="`/portfolio/${name}`"
                loading="lazy"
              > 
            <div class="overlay">
              <div class="description">
                {{this.metadata?.[name]?.['description'] ? this.metadata?.[name]?.['description']  : "" }}
              </div>
            </div>
          </div>
        </Transition >
      </div>
    </div>
</template>

<script>
const maxColumns           = 2
const msBetweenNextPicture = 250
const fadeTime             = 1
const waitForAnimation     = 250

// [...Array(folderSize)].map((i,j)=>j+1).reduce(
//         (arr, item, idx) => 
//         (arr[idx / columns | 0] ??= [])
//         .push(item) && arr, []),

export default{
  title: 'Main',
  data(){
    return {
      images: [],
      metadata: {},
      show: false
    }
  },
  async mounted(){   
    await this.updateColumns();
    // Allow animations to show before requesting all the images and slowing stuff down
    await new Promise(res=>setTimeout(res, waitForAnimation))
    // Get the description file here
    let noCacheRequest = new Headers()
      noCacheRequest.append('pragma', 'no-cache')
      noCacheRequest.append('cache-control', 'no-cache')
      const extras  = { method: 'GET', headers: noCacheRequest}
      const content = new Request('/portfolio/description.json')
    const res             = await fetch(content, extras)
    const description     = await res.json()
    const numPhotos       = description.photos.length

    this.metadata         = description.photos
    const photosPerColumn = Math.ceil(numPhotos/maxColumns)
    this.show=true

    // this.images = [...Array(numPhotos)].map((i,j)=>j+1).reduce(
    //     (arr, item, idx) => 
    //     (arr[idx / photosPerColumn | 0] ??= [])
    //     .push(item) && arr, [])

    // Assign pictures to the right columns
    for (let num=1;num<=numPhotos;num++){
      if(num % maxColumns !=0){
        // add picture to column
        this.images[(num % maxColumns)-1].push(`${description.photos[num-1].filename}`)
        // add description to picture if present 
        if (`${description.photos[num-1]?.description}`){
          this.metadata[`${description.photos[num-1].filename}`] = {
            "description" : `${description.photos[num-1].description}`
          }
        }
        await new Promise(res=>setTimeout(res,msBetweenNextPicture))
      }else{
        this.images[maxColumns-1].push(`${description.photos[num-1].filename}`)
        if (`${description.photos[num-1]?.description}`){
          this.metadata[`${description.photos[num-1].filename}`] = {
            "description" : `${description.photos[num-1].description}`
          }
        }
        await new Promise(res=>setTimeout(res,msBetweenNextPicture))
      }
    }

    /* attempt at lazy loading
    await new Promise(res=>setTimeout(res,1000))

    var lazyloadImages = document.querySelectorAll("img.lazy"); 
    for (let i=0; i<maxColumns; i++){
      lazyloadImages[i].src = lazyloadImages[i].getAttribute('data-src')
    }
      var lazyloadThrottleTimeout;
      
      async function lazyload () {
          console.log("Lazy Load activated")

          if(lazyloadThrottleTimeout) {
            clearTimeout(lazyloadThrottleTimeout);
          }    
          
          lazyloadThrottleTimeout = setTimeout(function() {
            var scrollTop = window.scrollY;
            lazyloadImages.forEach(function(img) {
              if(img.offsetTop < (window.innerHeight + scrollTop)) {
                img.src = img.getAttribute('data-src');
                console.log(img)
                img.classList.remove('lazy');
              }
            });
            if(lazyloadImages.length == 0) { 
              document.removeEventListener("scroll", lazyload, true);
              window.removeEventListener("resize", lazyload, true);
              window.removeEventListener("orientationChange", lazyload, true);
            }
          }, 1000);
        }
        document.addEventListener("scroll", lazyload, true);
        window.addEventListener("resize", lazyload, true);
        window.addEventListener("orientationChange", lazyload, true);
        */
  },
  methods: {
    async updateColumns(){
      var r = document.querySelector(':root');
      r.style.setProperty('--columns', maxColumns);
      r.style.setProperty('--fade-time', `${fadeTime}s`);
      let stupid = '[' +  '[],'.repeat(maxColumns-1) + '[]' + ']'
      this.images = JSON.parse(stupid)
    }
  },
}
</script>
<style scoped>
/* we will explain what these classes do next! */
.v-enter-active,
.v-leave-active {
  transition: opacity 2s ease;
}

.v-enter-from,
.v-leave-to {
  opacity: 0;
}
.grid-container {
  display: -ms-flexbox; /* IE10 */
  display: flex;
  -ms-flex-wrap: wrap; /* IE10 */
  flex-wrap: wrap;
  padding: 10px 65px 80px;
  padding-top: 60px;
  justify-content: center;
}

/* Create four equal columns that sits next to each other */
.grid-item {
  -ms-flex: calc(min(100% / var(--columns), 35%)); /* IE10 */
  flex: calc(min(100% / var(--columns), 35%));
  max-width: calc(min(100% / var(--columns), 35%));
  padding: 0 6px;
}

.grid-item img {
  margin-top: 12px;
  vertical-align: middle;
  width: 100%;
  animation: example var(--fade-time) ease;
  background: #F1F1FA;
}

@keyframes example {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}


/* Responsive layout - makes a two column-layout instead of four columns */
/* @media screen and (max-width: 1024px) {
  .grid-item {
    -ms-flex: 50%;
    flex: 50%;
    max-width: 50%;
  }
} */

/* Responsive layout - makes the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 1024px) {
  .grid-item {
    -ms-flex: 100%;
    flex: 100%;
    max-width: 100%;
  }
  .grid-item img{
    margin-top: 25px;
  }
  .grid-container{
    padding: 10px 15px;
    justify-items: center;
  }
}

.image-container{
  position: relative;
  width: 100%;
  /* background-color: black; */
  /* border: solid blue; */
}

.overlay{
  top: 12px;
  position: absolute;
  height: calc(100% - 12px);
  width: calc(100%);
  background-color: rgba(255, 255, 255,.4);
  z-index: 2;
  display: none;
}
@media screen and (max-width: 1024px) {
  .overlay{
    top: 25px;
    position: absolute;
    height: calc(100% - 25px);
  }
}
.description{
  position: absolute;
  bottom: 5px;
  font-family: Montserrat, sans-serif;
  font-size:17px;
  font-weight: 400;
  color: #303030;
  /* text-transform: uppercase; */
  left: 10px;
}

.image-container:hover .overlay{display: block;}

</style>