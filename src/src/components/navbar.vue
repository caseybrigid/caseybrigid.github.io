<template>
    <div v-if="w>1200" class="navbar">
        <router-link to="/" class="logo">
            Casey Su-Morrill
        </router-link>
        <div></div>
        <div>
            <div class="links">
                <router-link class="link"  :class='{active: (link==this.location)}'
                    v-for="link in links" :to="`/${link}`">{{ link }}
                </router-link>
            </div>
        </div>
    </div>
    <div v-else class="logo-containter">
        <div class="logo-containter-containter">
            <div class="logo">
               Casey Su-Morrill
            </div>
        </div>
        <input v-model="navbar" type="checkbox" id="checkbox3" class="checkbox3 visuallyHidden">
        <label for="checkbox3">
            <div class="hamburger hamburger3">
                <span class="bar bar1"></span>
                <span class="bar bar2"></span>
                <span class="bar bar3"></span>
                <span class="bar bar4"></span>
            </div>
        </label>
    </div>
    <Transition>
        <div v-if="navbar" class="navbar2-container">
            <div class="links-container">
                <div v-for="link in links" >
                    <router-link class="link" :class='{active: (link==this.location)}'
                     :to="`/${link}`" @click="navbar=false">
                     {{ link }}
                    </router-link>
                </div>
            </div>
        </div>
    </Transition>   
</template>
<script>

const links = [
    'portfolio',
    'polaroids',
    'contact'
]

export default{
    data(){
        return{
            links: links,
            h: window.innerHeight,
            w: window.innerWidth,
            location: window.location.pathname.replace('/',''),
            navbar: false
        }
    },
    mounted(){
        window.addEventListener('resize', this.onResize)
        this.$watch( ()=> this.$route.path,(to, from)=> {
         console.log('route path has changed from ' +from+' to '+to )
         this.location = window.location.pathname.replace('/','')
        })   
    },
    methods:{
        onResize(e){
            this.h = window.innerHeight
            this.w = window.innerWidth
        },
    }
}

</script>
<style>
.navbar{
    display: grid;
    width: 100%;
    grid-template-columns: auto auto 450px;
    padding: 35px 30px;
    /* position: absolute;
    background-color: white; */
}
@media only screen and (max-width: 1200px) {
  .navbar {
    grid-template-columns: auto;
    grid-template-columns:  80% ;
    align-items: center;
    justify-content: center;
    justify-items: center;
  }
}
.navbar2-container{
    position: absolute;
    width: 100vw;
    height: 100vh;
    background: white;
    z-index: 10;
}
.v-enter-active,
.v-leave-active {
  transition: opacity .3s ease;
}

.v-enter-from,
.v-leave-to {
  opacity: 0;
}
.links{
    align-content: center;
    width: 100%;
    height: 87px;
    display: grid;
    grid-template-columns:  repeat(5, min-content);
    grid-column-gap: 18px;
    justify-content: right;
    font-family: Lato, sans-serif;
    font-weight: 400;
    font-size: 15px;
    color: #000000;
    overflow:hidden;
    text-transform: uppercase;
    padding-right:15px;
    letter-spacing: .08rem;
}
.logo{
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif; /* fallback to arial if no helvetica */
  font-size: 58px;
  font-weight: 700;
  color: #303030;
  text-transform: uppercase;
  letter-spacing: .3rem;
  text-decoration: none;
  -webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    animation-delay: 5s;
    animation: example 1.5s ease;
    white-space: nowrap;
    overflow: hidden;
}
@media only screen and (max-width: 1200px) {
    .logo{
        font-size: 28px;
        height: max-content;
        overflow: auto;
        width: min-content;
        background: white;
        display: block;
        text-align: left;
    }
}
.logo-containter-contatiner{
    width: 360px;
}
.logo-containter{
    padding-top: 20px;
    display: grid;
    width: 100%;
    align-content: center;
    grid-template-columns: 360px;
    align-items: center;
    align-content: center;
    justify-content: center;
    justify-items: center;
    overflow: hidden;
    margin-bottom: 30px;
}
@keyframes example {
  from {
    width: 0;
  }
  to {
    width: 100%;
  }
}
.link{
    color: black;
    text-decoration: none;
    width: min-content;
    text-align: left;
    overflow:hidden;
}
:link:hover{
    opacity: .8;
    text-decoration: underline;
}
.active{
    text-decoration: underline;
}
.logo:hover{
    color: #555555;
    text-decoration: none;

}





.visuallyHidden {
    position: absolute; 
    overflow: hidden; 
    clip: rect(0 0 0 0); 
    height: 1px; width: 1px; 
    margin: -1px; padding: 0; border: 0; 
}

h1 {
    text-align: center;
}

.container {
    width: 70%;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
}

.hamburger {
    margin: 0 auto;
    margin-top: 30px;
    width: 35px;
    height: 30px;
    position: relative;
}

.hamburger .bar {
    padding: 0;
    width: 35px;
    height: 2px;
    background-color: black;
    display: block;
    border-radius: 4px;
    transition: all 0.2s ease-in-out;
    position: absolute; 
}

.bar1 {
    top: 0;
}
.bar2,
.bar3 {
    top: 13.5px;
}
.bar3 {
    right: 0;
}
.bar4 {
    bottom: 0;
}
.hamburger3 .bar1 {
    transform-origin: 5%;
}

.hamburger3 .bar4 {
    transform-origin: 5%;
}

.checkbox3:checked + label > .hamburger3 > .bar1{
    transform: rotate(45deg);
    height: 3px;
    width: 42px;
}

.checkbox3:checked + label > .hamburger3 > .bar3{
    transform: rotate(45deg);
    height: 3px;
    background-color: transparent;
}

.checkbox3:checked + label > .hamburger3 > .bar2{
    transform: rotate(-45deg);
    height: 3px;
    background-color: transparent;
}

.checkbox3:checked + label > .hamburger3 > .bar4{
    transform: rotate(-45deg);
    height: 3px;
    width: 42px;
}
.links-container{
    margin-top: 10vh;
    display: grid;
    width: 100%;
    align-content: center;
    justify-items: center;
    grid-gap: 5px;
}
@media only screen and (max-width: 1200px) {
    .link{
        width: 100%;
        font-size: 20px;
        font-family: lato, sans-serif;
        font-weight: 400;
        text-transform: uppercase;
        letter-spacing: .05rem;
        text-align: center;
    }   
}
</style>