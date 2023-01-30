import { Client, Databases, Account, ID } from 'appwrite';

const PROJECT_ID = "63caf356633daedc90d6";
const DATABASE_ID = "63caf4d3c63dfe21254e";
const COLLECTION_ID = "63ce7d8307846a399d7a";

const client = new Client();
const databases = new Databases(client);

client.setEndpoint('http://localhost/v1').setProject(PROJECT_ID);

export const account = new Account(client);

export const create = (data) =>
    databases.createDocument(DATABASE_ID, COLLECTION_ID, ID.unique(), data);

export const getList = () =>
    databases.listDocuments(DATABASE_ID, COLLECTION_ID);