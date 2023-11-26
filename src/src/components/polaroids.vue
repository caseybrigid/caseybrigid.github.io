<template>
    <div class="grid-container measurements">
        <p class="label">Measurements</p>
        Height - 6′ 1″<br> 
        Bust - 34″<br> 
        Waist - 26″<br> 
        Hips - 39″<br> 
        Dress - 4<br> 
        Shoe - US 9<br> 
    </div>
    <br>
    <div class="center">
        <div class="column">
            <div class="row">
                <img v-for="image in images" class="img" :src="`poloroids/${image}`"/>
            </div>
        </div>
    </div>  
</template>
<script>

export default{
    title: 'Polaroids',
    data(){
        return {
            images: [ "Close.jpg", 
                      "CloseSmile.jpg",
                      "ProfileClose.jpg",
                      "Upper.JPG",       
                      "Full.JPEG",                     
                      "LeftSide.jpg",       
                      "RightSide.jpg"
                    ]
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
  grid-template-columns: repeat(auto-fit, minmax(50%, 1fr));
  align-content: center;
}
.img{
  position: relative;
  /* background: black; */
  width: 100%;
  height: 100%;
  border: 3px solid white; 
  animation: example var(--fade-time) ease;
  object-fit: cover;
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