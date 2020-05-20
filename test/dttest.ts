import fetch from 'node-fetch';
import { ProjectApi, Configuration, ConfigurationParameters } from '../dtapi/index';

// use the environment variable APIKEY to set the key used in authentication
// without this variable set you will get unauthorized on the test
const apiKey = process.env.APIKEY || "";

const fetchParams: ConfigurationParameters = {
    // @ts-ignore
    fetchApi: fetch,
    apiKey: apiKey
}

const fetchConfig: Configuration = new Configuration(fetchParams);

const projects = new ProjectApi(fetchConfig);

projects.getSubscribeProjects({includeImported: true, pageSize: 1})
    .then((projs) => {
        console.log(JSON.stringify(projs.projects[0], null, 2));

        projects.getSubscribeProject({ id: projs.projects[0].id })
        .then((proj) => {
            console.log(JSON.stringify(proj, null, 2));
        })
        .catch((err) => {
            console.log("Error received:");
            console.log(err);
        });
    })
    .catch((err) => {
        console.log("Error received:");
        console.log(err);
    });

