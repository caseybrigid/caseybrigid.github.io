<template>
    <div class="grid-container">
        <div class="about">
            <div class="about content">
                Hi, I’m Casey! I am 22 years old and interested in fashion, beauty, and lifestyle modeling. I was born and raised in Albany, NY. My heritage is half-Irish, half-Chinese and has given me an appreciation for diversity and culture. Beyond modeling, I enjoy being in nature, running, ballroom dancing, and I have a degree in bioengineering.
            </div>
        </div>
        <div>
            <img class="imgoffset" :src="`/about/1.JPG`"/>
        </div>
    </div>
</template>
<script>
export default{
    title: "About"
}
</script>

<style scoped>
.grid-container{
    display: grid;
    grid-template-columns: 50% 50%;
    width: 100%;
    /* background: blue; */
    /* align-content: center;
    grid-template-columns:  repeat(5, min-content);
    grid-column-gap: 18px;
    justify-content: right;
    font-family: Lato, sans-serif;
    font-weight: 400;
    font-size: 22px;
    color: #000000;
    overflow:hidden;
    text-transform: uppercase;
    padding-right:15px;
    letter-spacing: .08rem; */
}

.about{
    display: grid;
    margin-top: -50px;
    align-content: center;
    justify-content: center;
    /* background: grey; */
}

.content{
    font-family: Lato, sans-serif;
    font-size: 22px;
    font-weight: 400;
    color: #000000;
    width: 400px;
    height: min-content;
}

.imgoffset{
    width: 400px;
    object-fit: cover;
    float: right;
}

@media only screen and (max-width: 1200px) {
  .grid-container {
    padding: 20px;
    grid-template-columns:  100%;
    align-items: center;
    justify-content: center;
    justify-items: center;
    overflow: hidden;
    grid-row-gap: 30px;
  }
  .content{
    width: 300px;
    font-size: 20px;
  }
  .about{
    margin-top: 0px;
  }
  .imgoffset{
    width: 100%;
    object-fit: cover;
}
}
</style>