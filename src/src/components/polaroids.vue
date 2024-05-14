<template>
    <div class="grid-container measurements">
        <p class="label">Measurements</p>
        Height - 6′ 1″<br> 
        Bust - 34″<br> 
        Waist - 25″<br> 
        Hips - 38″<br> 
        Dress - 4<br> 
        Shoe - US 9<br> 
    </div>
    <br>
    <div class="center">
      <div class="column">
        <div class="row">
          <div v-for="image,index in images" >
                <img v-show="image.loaded" v-loadedifcomplete="image"
                @load="image.loaded = true" class="img" :src="`/poloroids/${index+1}.jpg`">
                <!-- <img v-show="!image.loaded" class="waiting"> -->
          </div>
      </div>
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
    font-size  : 16px;
    font-weight: 400;
    line-height: 20px;
    color      : black;
    text-align: center;
    text-transform: uppercase;
}
.measurements{
    font-family: Lato, sans-serif;
    font-size  : 22px;
    font-weight: 400;
    line-height: 21px;
    color      : black;
    text-align: center;
}
.center{
  width: 100%;
  display: grid;
  justify-items: center;
}
.column{
	width: 50%;
	display: grid;
  /* background: blue; */
  /* padding: 5px; */
}
.row{
	width: 100%;
	display: grid;
  /* background: grey; */
  /* padding: 5px; */
  grid-template-columns: repeat(auto-fit, 50%);
  align-content: center;
  align-items: center;
}
.img{
  position: relative;
  /* background: black; */
  width: 100%;
  border: 3px solid white; 
  animation: example var(--fade-time) ease;
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
    width: 90%;
    display: grid;
    /* background: blue; */
    /* padding: 5px; */
  }
}
</style>