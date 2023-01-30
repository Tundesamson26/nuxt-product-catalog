<template>
  <div class="product-catalog bg">
    <div class="product-container mt-8 md:mt-0 md:col-span-2 bg-black">
      <form action="#" method="POST" class="mt-5">
        <div class="shadow sm:rounded-md sm:overflow-hidden">
          <div class="px-4 py-5 bg-white space-y-6 sm:p-6">
            <div>
              <label
                for="about"
                class="block text-sm font-medium text-gray-700"
              >
                Product Name
              </label>
              <div class="mt-1">
                <textarea
                  v-model="productName"
                  name="about"
                  class="
                    shadow-sm
                    focus:ring-indigo-500 focus:border-indigo-500
                    mt-1
                    block
                    w-full
                    sm:text-sm
                    border border-gray-300
                    rounded-md
                  "
                />
              </div>
            </div>
            <div class="grid grid-cols-3 gap-6">
              <div class="col-span-3 sm:col-span-2">
                <label
                  for="company_website"
                  class="block text-sm font-medium text-gray-700"
                >
                  Link to Product Image
                </label>
                <div class="mt-1 flex rounded-md shadow-sm">
                  <input
                    type="text"
                    name="company_website"
                    v-model="productImage"
                    class="
                      focus:ring-indigo-500 focus:border-indigo-500
                      flex-1
                      block
                      w-full
                      rounded-none rounded-r-md
                      sm:text-sm
                      border-gray-300
                    "
                    placeholder="www.example.com"
                  />
                </div>
              </div>
            </div>
            <div>
              <label
                for="price"
                class="block text-sm font-medium text-gray-700"
              >
                Price
              </label>
              <div class="mt-1 relative rounded-md shadow-sm">
                <div
                  class="
                    absolute
                    inset-y-0
                    left-0
                    pl-3
                    flex
                    items-center
                    pointer-events-none
                  "
                >
                  <span class="text-gray-500 sm:text-sm">$</span>
                </div>
                <input
                  type="text"
                  name="price"
                  v-model="productPrice"
                  class="
                    focus:ring-indigo-500 focus:border-indigo-500
                    block
                    w-full
                    pl-7
                    pr-12
                    sm:text-sm
                    border-gray-300
                    rounded-md
                  "
                  placeholder="0.00"
                />
              </div>
            </div>
            <div class="px-4 py-3 bg-gray-50 text-right sm:px-6">
              <button
                type="button"
                class="
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
                "
                @click.prevent="uploadProduct"
              >
                Save
              </button>
            </div>
          </div>
        </div>
      </form>
    </div>
    <div>
      <Products
        v-for="product in products"
        :key="product.$id"
        :productName="product.productName"
        :productImage="product.productImage"
        :productPrice="product.productPrice"
      />
    </div>
  </div>
</template>

<script>
import { Client, Account, Databases, Graphql } from "appwrite";

const client = new Client();

client
  .setEndpoint("http://localhost/v1") // The Appwrite Endpoint
  .setProject("63caf356633daedc90d6");

const account = new Account(client);
const database = new Databases(client);
const graphql = new Graphql(client);

account.createAnonymousSession().then(
  (response) => {
    console.log(response);
  },
  (error) => {
    console.log(error);
  }
);

export default {
  name: "IndexPage",

  data() {
    return {
      products: [],
      productName: "",
      productImage: "",
      productPrice: "",
    };
  },

  mounted() {
    this.getProducts();

    if (account.get !== null) {
      try {
        client.subscribe("documents", (response) => {
          console.log(response);
        });
      } catch (error) {
        console.log(error, "error");
      }
    }
  },

  methods: {
    async uploadProduct() {
      await database.createDocument(
        "63caf4d3c63dfe21254e",
        "63ce7d8307846a399d7a",
        "unique()",
        {
          productName: this.productName,
          productImage: this.productImage,
          productPrice: this.productPrice,
        }
      );
      const mutation = await graphql.mutation({
        query: `mutation CreateDocument(
        $databaseId: String!,
        $collectionId: String!,
        $documentId: String!
    ) {
        databasesCreateDocument(
            databaseId: $63caf4d3c63dfe21254e,
            collectionId: $63ce7d8307846a399d7a,
            documentId: "ID.unique()"
        ) {
            _id
        }
    }`,
        variables: {
          database,
          collectionId,
          documentId: ID.unique(),
        },
      });
      mutation
        .then((response) => {
          console.log(response);
        })
        .catch((error) => {
          console.log(error);
        });
    },

    async getProducts() {
      let products = [];

      let productData = await database.listDocument(
        "63caf4d3c63dfe21254e",
        "63ce7d8307846a399d7a"
      );
      products.push({
        productName: productData.documents[0].productName,
        productImage: productData.documents[0].productImage,
        productPrice: productData.documents[0].productPrice,
      });

      const query = await graphql.query({
        query: `query ListDocument(
        $databaseId: String!,
        $collectionId: String!,
    ) {
        databasesListDocument(
            databaseId: $63caf4d3c63dfe21254e,
            collectionId: $63ce7d8307846a399d7a,
        ) {
          total
          documents{
            _id
            _databaseId
            _collectionId
            _createdAt
            _updatedAt
            _permissions
            data
          }       
        }
    }`
      });
      query
        .then((response) => {
          console.log(response);
        })
        .catch((error) => {
          console.log(error);
        });

      this.products = products;
    },
  }
   
};
</script>

<style>
</style>
