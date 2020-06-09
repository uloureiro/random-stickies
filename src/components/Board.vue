<template>
  <v-content dark>
    <v-toolbar dark>
      <v-spacer></v-spacer>
      <v-toolbar-title display-1>
        <div class="display-1 font-weight-thin" style="border: none" contenteditable>
          {{ name }}
        </div>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn fab color="grey darken-3" right bottom absolute @click="addLane">
        <v-icon>mdi-plus</v-icon>
      </v-btn>
    </v-toolbar>
    <v-container fluid class="grey" style="min-height:calc(100vh - 120px);">
      <v-row>
        <v-col v-for="(lane, n) in lanes" :key="n" style="min-height:calc(100vh - 160px);">
          <Lane :id="lane.id" :name="lane.name" :color="lane.color" />
        </v-col>
      </v-row>
    </v-container>
  </v-content>
</template>

<script lang="ts">
import Vue from "vue";
import Lane from "./Lane";

export default Vue.extend({
  components: { Lane },
  data: () => {
    let name = "My board";
    let lanes = [
      { id: "lane1" },
      { id: "lane2" },
      { id: "lane3", color: "#789789" }
    ];
    return { name, lanes };
  },
  methods: {
    addLane: function() {
      this.lanes.push({ id: "lane" + this.lanesCount, name: "New lane" });
    }
  },
  computed: {
    lanesCount: function() {
      return this.lanes.count
    }
  }
});
</script>

<style scoped>
.v-toolbar__title {
  cursor: pointer;
}
[contenteditable]:focus {
    outline: 0px solid transparent;
}
</style>