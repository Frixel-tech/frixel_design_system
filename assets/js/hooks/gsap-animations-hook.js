import { gsap } from "../../vendor/gsap/gsap.min.js";
import { CustomEase } from "../../vendor/gsap/CustomEase.min.js";
import { ScrollTrigger } from "../../vendor/gsap/ScrollTrigger.min.js";

const CardStackingAnimationHook = {
  mounted() {
    gsap.utils.toArray(":scope > *", this.el).forEach((card, cardIndex, cardList) => {
      const isLastCard = (cardIndex + 1) == cardList.length ? true : false

      if (!isLastCard) {
        gsap.to(card, {
          scrollTrigger: {
            trigger: cardList[cardIndex + 1],
            start: "top 95%",
            end: "bottom 25%",
            scrub: 0.5
          },
          scale: 0.90,
          duration: 3
        })
      }
    })
  }
}

const DelayedFadeInAnimationHook = {
  mounted() {
    gsap.utils.toArray(":scope > *", this.el).forEach((animatedElement, index) => {
      gsap.from(animatedElement, {
        scrollTrigger: {
          trigger: this.el,
          start: "5% 75%",
          end: "center center"
        },
        autoAlpha: 0,
        y: 50,
        duration: 1,
        ease: CustomEase.create("cubic-bezier", ".3,0,0,1"),
        delay: index * 0.2
      })
    })
  },
  updated() {
    gsap.utils.toArray(":scope > *", this.el).forEach((animatedElement, index) => {
      gsap.from(animatedElement, {
        scrollTrigger: {
          trigger: this.el,
        },
        autoAlpha: 0,
        duration: 0
      })
    })
  }
}

const FadeInAnimationHook = {
  mounted() {
    // Animation jouée uniquement lors de l'insertion initiale
    gsap.from(this.el, {
      scrollTrigger: {
        trigger: this.el,
        start: "5% 75%",
        end: "center center"
      },
      autoAlpha: 0,
      y: 50,
      duration: 1,
      ease: CustomEase.create("cubic-bezier", ".3,0,0,1")
    })
  },

  updated() {
    gsap.from(this.el, {
      autoAlpha: 0,
      duration: 0
    });
  }
};

// Entering animation where two elements are coming from both side of the screen 
const LateralSlideFromBothSideHook = {
  mounted() {
    gsap.utils.toArray(":scope > *", this.el).forEach((animatedElement, index) => {
      console.log(animatedElement)
      gsap.from(animatedElement, {
        ScrollTrigger: {
          markers: true,
          trigger: this.el,
          start: "5% 75%",
          end: "center center"
        },
        autoAlpha: 0,
        x: index == 0 ? '-50vw' : '50vw',
        duration: 1,
        ease: CustomEase.create("cubic-bezier", ".3,0,0,1"),
      })
    })
  },

  updated() {
    gsap.utils.toArray(":scope > *", this.el).forEach((animatedElement) => {
      gsap.from(animatedElement, {
        ScrollTrigger: {
          trigger: this.el
        },
        autoAlpha: 0,
        duration: 0,
      })
    })

  }
}

// TODO: maybe try GSAP plugin Inertia to do better parallax (because it is free now)
const ParallaxAnimationHook = {
  xPosition() { return this.el.dataset.xPosition },
  mounted() {
    const currentElement = this.el;

    let getRatio = el => window.innerHeight / (window.innerHeight + el.offsetHeight);

    gsap.fromTo(currentElement, {
      backgroundPosition: `${this.xPosition()} 0px`
    }, {
      scrollTrigger: {
        trigger: currentElement,
        start: "top top",
        end: "bottom top",
        scrub: true,
        invalidateOnRefresh: true // to make it responsive
      },
      backgroundPosition: `${this.xPosition()} ${window.innerHeight * (0.7 - getRatio(currentElement))}px`,
      ease: CustomEase.create("cubic-bezier", ".3,0,0,1")
    })
  }
}

export { CardStackingAnimationHook, DelayedFadeInAnimationHook, FadeInAnimationHook, LateralSlideFromBothSideHook, ParallaxAnimationHook };
