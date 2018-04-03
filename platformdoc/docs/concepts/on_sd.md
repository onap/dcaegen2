NOTE: THIS PAGE IS A STUB RIGHT NOW. NEEDS EDITING AND WORK. 

# CDAP Cuda Service discovery example.

NOTE: The below URLs were temporary when the app was deployed, they are no longer valid.
However you can re-create all of this using the commands in https://codecloud.web.att.com/projects/ST_DCAECNTR/repos/dcae_cli_cdap_examples/browse/cuda.

I deployed CUDA and got back the instance name: b30b7b640fa14539890efa768b4649a2.70900c87-1c82-4690-a0b1-e0aa72cbab84.0-4-1.cdap-cuda.rework-central.dcae.ecomp.att.com.

If another DCAE service component, like a collector or downstream analytics, were to perform a service lookup on this CUDA app, they would eventually get back a broker URL: http://135.205.226.76:32773/application/b30b7b640fa14539890efa768b4649a2.70900c87-1c82-4690-a0b1-e0aa72cbab84.0-4-1.cdap-cuda.rework-central.dcae.ecomp.att.com
 
Which returns a  JSON that looks like this:

```
{  
   "appname":"b30b7b640fa14539890efa768b4649a2.70900c87-1c82-4690-a0b1-e0aa72cbab84.0-4-1.cdap-cuda.rework-central.dcae.ecomp.att.com",
   "namespace":"cuda",
   "healthcheckurl":"http://135.205.226.76:32773/application/b30b7b640fa14539890efa768b4649a2.70900c87-1c82-4690-a0b1-e0aa72cbab84.0-4-1.cdap-cuda.rework-central.dcae.ecomp.att.com/healthcheck",
   "metricsurl":"http://135.205.226.76:32773/application/b30b7b640fa14539890efa768b4649a2.70900c87-1c82-4690-a0b1-e0aa72cbab84.0-4-1.cdap-cuda.rework-central.dcae.ecomp.att.com/metrics",
   "url":"http://135.205.226.76:32773/application/b30b7b640fa14539890efa768b4649a2.70900c87-1c82-4690-a0b1-e0aa72cbab84.0-4-1.cdap-cuda.rework-central.dcae.ecomp.att.com",
   "connectionurl":"http://135.205.226.110:11015/v3/namespaces/cuda/streams/cuda_appInputStream",
   "serviceendpoints":[  
      {  
         "url":"http://135.205.226.110:11015/v3/namespaces/cuda/apps/b30b7b640fa14539890efa768b4649a270900c871c824690a0b1e0aa72cbab84041cdapcudareworkcentraldcaeecompattcom/services/cuda_appOutputDataQuery/methods/allrows",
         "method":"GET"
      },
      {  
         "url":"http://135.205.226.110:11015/v3/namespaces/cuda/apps/b30b7b640fa14539890efa768b4649a270900c871c824690a0b1e0aa72cbab84041cdapcudareworkcentraldcaeecompattcom/services/cuda_appOutputDataQuery/methods/lastrow",
         "method":"GET"
      }
   ]
}
```

There are important service discovery keys in this JSON. The first is connectionurl. That is the full URL to this application’s stream. The collector can POST data to that URL.
 
The second important key is serviceendpoints. These are formed using the information found in the spec. These are, again like connectionurl, full URIs that point to the actual data service. You can try hitting one of those in your browser: http://135.205.226.110:11015/v3/namespaces/cuda/apps/b30b7b640fa14539890efa768b4649a270900c871c824690a0b1e0aa72cbab84041cdapcudareworkcentraldcaeecompattcom/services/cuda_appOutputDataQuery/methods/allrows
 
And you will get back the output: 
``` 
[  
   {  
      "[0]":"{\"start\": 1, \"engagements\": [{\"transcript\": [{\"type\": \"chat.scriptlineSent\", \"senderId\": \"ss754c\", \"content\": \"My SSN is $Identity.ssn. $Identity.name, Thanks for choosing       AT\u0026T. My name is $Identity.name and I will be happy to assist you with our plans and services.\", \"iso\": \"2016-05-31T21:59:55-07:00\", \"timestamp\": 1464757195034, \"senderName\":                \"agent\"}], \"engagementID\": \"744878782903999181\"}], \"numFound\": 1}"
   }
]
```
This is what we call “service discovery”. A component wants to know how to connect to an application and all they know is that applications name. Through a series of HTTP calls which I’m glossing over here, they eventually get back the URL I showed above which returns that JSON containing all important URLs associated with that application. 

When DMaaP is introduced, this conversation is going to change. In that case, instead of discovering an application directly, you may instead discover a feed that feeds into/out of that app.
 
 
 
