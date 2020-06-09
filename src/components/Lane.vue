<template>
  <v-hover v-slot:default="{ hover }">
    <v-card
      class="pa-5 ma-3 pt-0"
      elevation="5"
      style="height:100%"
      :color="colorInternal"
    >
      <v-fade-transition>
        <v-btn
          dark
          color="grey darken-1"
          v-if="hover"
          fab
          small
          top
          right
          absolute
          v-on:click="addSticky"
          alt="Add sticky"
          style="margin-right: 90px"
        >
          <v-icon>mdi-plus</v-icon>
        </v-btn>
      </v-fade-transition>

      <v-menu
        :close-on-content-click="false"
        :nudge-width="200"
        offset-y
        absolute>
        <template v-slot:activator="{ on }">
          <v-fade-transition>
            <v-btn
              dark
              color="grey darken-1"
              v-if="hover"
              fab
              small
              top
              right
              absolute
              alt="Edit lane"
              v-on="on"
              style="margin-right: 45px"
            >
              <v-icon>mdi-pencil</v-icon>
            </v-btn>
          </v-fade-transition>
        </template>
        <v-card class="ma-3 pa-2">
          <v-text-field
            class="pa-2 ma-2"
            v-model="nameInternal"
            label="Lane name"
            hide-details
            placeholder="Add your lane name here..."
          ></v-text-field>
          <v-text-field
            class="pa-2 ma-2"
            v-model="colorInternal"
            label="Lane color"
            hide-details
          >
            <template v-slot:append>
              <v-menu
                top
                v-model="colorPickerState"
                nudge-bottom="105"
                nudge-left="16"
                :close-on-content-click="false"
              >
                <template v-slot:activator="{ on }">
                  <div :style="swatchStyle" v-on="on" />
                </template>
                <v-color-picker
                  :value="colorInternal"
                  :swatches="colorPalette"
                  v-on:update:color="propagateColorChange($event)"
                  class="ma-2"
                  mode="hexa"
                  hide-inputs
                  show-swatches
                  dot-size="20"
                />
              </v-menu>
            </template>
          </v-text-field>
        </v-card>
      </v-menu>

      <v-fade-transition>
        <v-btn
          dark
          color="grey darken-1"
          v-if="hover"
          fab
          small
          top
          right
          absolute
          v-on:click="emitRemoveMe($event)"
          alt="Remove lane"
        >
          <v-icon>mdi-delete-forever</v-icon>
        </v-btn>
      </v-fade-transition>
      <v-card-title no-gutters style="min-height:65px" class="pa-0 pt-5">
        <span style="min-width: 95px">&nbsp;</span>
        <v-spacer></v-spacer>
        <div class="font-weight-light" style="border: none">
          {{ nameInternal }}
        </div>
        <v-spacer></v-spacer>
        <span style="min-width: 95px">&nbsp;</span>
      </v-card-title>
      <v-container fluid class="mt-1">
        <v-row>
          <v-col v-for="(sticky, index) in stickies" :key="index">
            <Sticky
              :id="sticky.id"
              :text="sticky.text"
              :color="stickyColor"
              v-on:remove-me="removeSticky"
            />
          </v-col>
        </v-row>
      </v-container>
    </v-card>
  </v-hover>
</template>

<script lang="ts">
import Vue from "vue";
import Sticky from "./Sticky";

export default Vue.extend({
  components: {
    Sticky,
  },
  props: {
    id: {
      type: String,
    },
    name: {
      type: String,
      default: "My lane",
    },
    color: {
      type: String,
      default: "#FFFFFFFF",
    },
  },
  data: function() {
    let stickies = new Array();
    let nameInternal = this.name;
    let colorInternal = this.color;
    let colorPickerState = false;

    return {
      stickies,
      colorInternal,
      nameInternal,
      colorPickerState,
    };
  },
  methods: {
    addSticky: function() {
      let id = "sticky" + (this.stickiesCount + 1);
      this.stickies.push({ id: id, text: "" });
    },
    removeSticky: function(id) {
      let index = this.stickies.findIndex(function(el) {
        return el.id == id;
      });
      if (index >= 0) {
        this.stickies.splice(index, 1);
      }
    },
    colorLuminance: (hex, lum) => {
      // TODO do that properly
      // validate hex string
      hex = String(hex).replace(/[^0-9a-f]/gi, "");
      if (hex.length < 6) {
        hex = hex[0] + hex[0] + hex[1] + hex[1] + hex[2] + hex[2];
      }
      lum = lum || 0;

      // convert to decimal and change luminosity
      var rgb = "#", c, i;
      for (i = 0; i < 3; i++) {
        c = parseInt(hex.substr(i * 2, 2), 16);
        c = Math.round(Math.min(Math.max(0, c + c * lum), 255)).toString(16);
        rgb += ("00" + c).substr(c.length);
      }

      return rgb;
    },
    propagateColorChange: function(color) {
      this.colorInternal = color.hexa;
    },
    emitRemoveMe: function() {
      this.$emit("remove-me", this.id)
    },
  },
  computed: {
    stickiesCount: function() {
      return this.stickies.length;
    },
    stickyColor: function() {
      return this.colorLuminance(this.colorInternal, 0.6);
    },
    swatchStyle() {
      const { colorInternal, colorPickerState } = this;
      return {
        backgroundColor: colorInternal,
        cursor: "pointer",
        height: "25px",
        width: "25px",
        borderRadius: colorPickerState ? "50%" : "4px",
        transition: "border-radius 200ms ease-in-out",
        border: "1px solid #BBB",
      };
    },
    colorPalette() {
      return [
        ["#f44336", "#E91E63", "#9C27B0", "#673AB7"],
        ["#3F51B5", "#2196F3", "#03A9F4", "#00BCD4"],
        ["#009688", "#4CAF50", "#8BC34A", "#CDDC39"],
        ["#FFEB3B", "#FFC107", "#FF9800", "#FF5722"],
        ["#795548", "#9E9E9E", "#607D8B", "#263238"],
      ];
    },
  },
});
</script>

<style scoped>
.v-card__title {
  cursor: default;
}
</style>
