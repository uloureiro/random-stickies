<template>
  <v-hover v-slot:default="{ hover }">
    <v-card class="pa-5 ma-3 pt-0" elevation="5" style="height:100%" :color="color">
      <v-card-title no-gutter style="min-height:65px" class="pa-0 pt-5">
        <span style="min-width: 95px">&nbsp;</span>
        <v-spacer></v-spacer>
        <div class="font-weight-light">{{ name }}</div>
        <v-spacer></v-spacer>
        <span style="min-width: 95px">
        <v-fade-transition>
          <v-btn
            dark
            color="grey darken-1"
            v-if="hover"
            small
            fab
            v-on:click="addSticky"
            alt="Add sticky"
            class="mr-3"
          >
            <v-icon>mdi-plus</v-icon>
          </v-btn>
        </v-fade-transition>
        <v-menu
          :close-on-content-click="false"
          :nudge-width="200"
          offset-y
          absolute
        >
          <template v-slot:activator="{ on }">
            <v-fade-transition>
              <v-btn
                dark
                color="grey darken-1"
                v-if="hover"
                fab
                small
                alt="Edit lane"
                v-on="on"
              >
                <v-icon>mdi-pencil</v-icon>
              </v-btn>
            </v-fade-transition>
          </template>
          <v-color-picker class="ma-2" show-swatches swatches-max-height="200px" mode="hexa" hide-mode-switch v-model="color"></v-color-picker>
        </v-menu>
        </span>
      </v-card-title>
      <v-container fluid class="mt-1">
        <v-row>
          <v-col v-for="sticky in stickies" :key="sticky">
            <Sticky :text="sticky" :color="colorLuminance(color, 0.5)" />
          </v-col>
        </v-row>
      </v-container>
    </v-card>
  </v-hover>
</template>

<script lang="ts">
import Vue from "vue"
import Sticky from "./Sticky"

export default Vue.extend({
  components: {
    Sticky
  },
  props: {
    name: {
      type: String,
      default: "My lane"
    },
    color: {
      type: String,
      default: "#FFF"
    }
  },
  data: () => {
    let stickies = ["Sticky 1", "Sticky 2"]
    let name = "My lane"
    let color = "#FFF"
    return { name, color, stickies }
  },
  methods: {
    addSticky: function() {
      this.stickies.push("New sticky")
    },
    getName: () => {
      return this.internalName
    },
    setName: (name) => {
      this.internalName = name
    },
    setColor: (value) => {
      return this.color = value
    },
    colorLuminance: (hex, lum) => {
      // TODO do that properly
      // validate hex string
      hex = String(hex).replace(/[^0-9a-f]/gi, '');
      if (hex.length < 6) {
        hex = hex[0]+hex[0]+hex[1]+hex[1]+hex[2]+hex[2];
      }
      lum = lum || 0;

      // convert to decimal and change luminosity
      var rgb = "#", c, i;
      for (i = 0; i < 3; i++) {
        c = parseInt(hex.substr(i*2,2), 16);
        c = Math.round(Math.min(Math.max(0, c + (c * lum)), 255)).toString(16);
        rgb += ("00"+c).substr(c.length);
      }

      return rgb;
    },
  }
});
</script>

<style scoped>
.fab-container {
  position: absolute;
}
</style>