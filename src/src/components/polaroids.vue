<template>
  <div class="grid-container measurements">
      <p class="label">Measurements</p>
      Height - 6′ 1″<br> 
      Bust - 34″<br> 
      Waist - 24″<br> 
      Hips - 37″<br> 
      Dress - 4<br> 
      Shoe - US 9<br> 
  </div>
  <br>
  <div class="center">
    <div class="column">
      <!-- <div class="row" v-for="item,index in Array(Math.floor(images.length/2))">
        <img  v-for="image,imageindex in images.slice(index*(Math.floor(images.length/2)),((index+1)*(Math.floor(images.length/2))))" v-show="image.loaded" v-loadedifcomplete="image"
        @load="image.loaded = true" class="img" :src="`/poloroids/${(index*images.length/2)+imageindex+1}.jpg`"> -->
        <!-- <img v-show="!image.loaded" class="waiting"> -->
      <!-- </div> -->
      <img  v-for="image,index in images" v-show="image.loaded" v-loadedifcomplete="image"
        @load="image.loaded = true" class="img" :src="`/poloroids/${(index)+1}.jpg`">
    </div>  

  </div> 
</template>
<script>

export default{
    title: 'Polaroids',
    directives: {
      loadedifcomplete: function(el, binding) {
        if (el.complete) {
          binding.value.loaded = true;
        }
      }
    },
    data(){
        return {
            images: [{},{},{},{}],
            show: false
        }
    }
}
</script>
<style scoped>
.grid-container{
    margin-top: 40px;
    display: grid;
    justify-items: center;
    width: 100%;
}
.label{
    font-family: Lato, sans-serif;
    font-size  : 20px;
    font-weight: 400;
    line-height: 20px;
    color      : var(--font-color);
    text-align: center;
    text-transform: uppercase;
    padding-bottom: 10px;
}
.measurements{
    font-family: Lato, sans-serif;
    font-size  : 22px;
    font-weight: 400;
    line-height: 21px;
    color      : var(--font-color);
    text-align : center;
}
.center{
  width: 100%;
  height: max-content;
  display: grid;
  justify-items: center;
  grid-gap: 0px;
}
.column{
  height: 100%;
	width: 100%;
	display: grid;
  grid-template-columns: repeat(4, calc(100%/4 - 6px));
  grid-column-gap: 6px;
  grid-row-gap: 6px;
  align-content: center;
  align-items: center;
  justify-content: center;
  padding: 10px;
}
.row{
	width: 100%;
	display: grid;
  /* background: grey; */
  /* padding: 5px; */
  grid-template-columns: repeat(calc(100%/4 - 6px), 4);
  align-content: center;
  align-items: center;
  grid-column-gap: 6px;
}
.img{
  position: relative;
  /* background: black; */
  width: 100%;
  height: 100%;
  /* border: 3px solid white;  */
  animation: example var(--fade-time) ease;
  /* border: 1px solid black; */
  padding: 0px;
  margin: 0px;
}
@keyframes example {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

@media screen and (max-width: 1024px) {
  .column{
    width: 95%;
    display: grid;
    grid-template-columns: repeat(2, calc(100%/2 - 6px));
    grid-column-gap: 6px;
    align-content: center;
    align-items: center;
    justify-content: center;
    padding: 0px;
  }
}
</style>