<template>
  <div class="bg-white">
    <div class="max-w-2xl mx-auto py-16 px-4 sm:py-24 sm:px-6 lg:max-w-7xl lg:px-8">
      <h2 class="sr-only">Products</h2>

      <div class="
          grid grid-cols-1
          gap-y-10
          sm:grid-cols-2
          gap-x-6
          lg:grid-cols-3
          xl:grid-cols-4 xl:gap-x-8
        ">
        <a href="#" class="group">
          <div class="
              w-full
              aspect-w-1 aspect-h-1
              bg-gray-200
              rounded-lg
              overflow-hidden
              xl:aspect-w-7 xl:aspect-h-8
            ">
            <img :src="productImage"
              alt="Tall slender porcelain bottle with natural clay textured body and cork stopper." class="
                w-full
                h-full
                object-center object-cover
                group-hover:opacity-75
              " />
          </div>
          <h3 class="mt-4 text-sm text-gray-700">{{ productName }}</h3>
          <p class="mt-1 text-lg font-medium text-gray-900">
            ${{ productPrice }}
          </p>
          <button type="button" class="
              cursor
              inline-flex
              justify-center
              py-2
              px-4
              border border-transparent
              shadow-sm
              text-sm
              font-medium
              rounded-md
              text-white
              bg-fuchsia-600
              hover:bg-fuchsia-700
              focus:outline-none
              focus:ring-2
              focus:ring-offset-2
              focus:ring-fuchsia-500
            ">
            Delete
          </button>
        </a>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "Products",
  props: {
    productName: String,
    productPrice: Number,
    productImage: String,
  },
};
</script>
<style>

</style>
