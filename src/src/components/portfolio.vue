<template>
  <!-- Reference https://www.w3schools.com/howto/tryit.asp?filename=tryhow_css_image_grid_responsive -->
    <div class="grid-container">
      <div v-for="group in images" class="grid-item">
        <Transition v-for="name in group">
          <div v-if="show" class="image-container">
            <img 
                alt=""
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
const maxColumns = 4
const columns    = 3;
const folderSize = 11;

// [...Array(folderSize)].map((i,j)=>j+1).reduce(
//         (arr, item, idx) => 
//         (arr[idx / columns | 0] ??= [])
//         .push(item) && arr, []),

export default{
  title: 'Main',
  data(){
    return {
      images: [[],[],[],[]],
      metadata: [],
      show: false
    }
  },
  async mounted(){
    // Allow animations to show before requesting all the images and slowing stuff down
    await new Promise(res=>setTimeout(res,1000))
    // Get the description file here
    const res             = await fetch('/portfolio/description.json')
    const description     = await res.json()
    const numPhotos       = description.numberofphotos

    this.metadata         = description.photos
    const photosPerColumn = Math.ceil(numPhotos/maxColumns)
    // this.images = [...Array(numPhotos)].map((i,j)=>j+1).reduce(
    //     (arr, item, idx) => 
    //     (arr[idx / photosPerColumn | 0] ??= [])
    //     .push(item) && arr, [])
    for (let num=1;num<=numPhotos;num++){
      if(num % maxColumns !=0){
        this.images[(num % maxColumns)-1].push(`${num}.JPG`)
        console.log(num,"went to",(num % maxColumns)-1)
      }else{
        this.images[3].push(`${num}.JPG`)
        console.log(num,"went to", 3)
      }
    }
    this.show=true
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
/* .grid-container{
  display: grid;
  align-items: center;
  justify-items: center;
  justify-content: center;
  align-content: center;
  width: 100vw;
  grid-template-columns: repeat(4, calc((100vw - 40px - 40px)/4));
  grid-column-gap      : 10px;
  padding-left : 20px;
  padding-right: 20px;
}
@media only screen and (max-width: 1024px) {
  .grid-container {
    grid-template-columns:  90% ;
  }
}
.grid-item{
  object-fit: cover;
  overflow: hidden;
}
.img-container{
  width: 100%;
  object-fit: cover;
} */
.grid-container {
  display: -ms-flexbox; /* IE10 */
  display: flex;
  -ms-flex-wrap: wrap; /* IE10 */
  flex-wrap: wrap;
  padding: 10px 65px 80px;
  padding-top: 60px;
}

/* Create four equal columns that sits next to each other */
.grid-item {
  -ms-flex: 25%; /* IE10 */
  flex: 25%;
  max-width: 25%;
  padding: 0 6px;
}

.grid-item img {
  margin-top: 12px;
  vertical-align: middle;
  width: 100%;
  animation: example 3s ease;
}

@keyframes example {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

.grid-item img:hover{
  /* opacity: .7; */
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