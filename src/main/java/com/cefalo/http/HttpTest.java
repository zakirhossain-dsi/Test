package com.cefalo.http;

import org.apache.http.Header;
import org.apache.http.HttpHeaders;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.client.methods.RequestBuilder;
import org.apache.http.client.params.ClientPNames;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpParams;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class HttpTest {
    public static void main(String[] args) throws IOException {
        Header header = new BasicHeader(HttpHeaders.CONTENT_TYPE, "application/json");
        List<Header> headers = Arrays.asList(header);
        HttpClient client = HttpClients.custom().setDefaultHeaders(headers).build();
        HttpUriRequest request = RequestBuilder.get().setUri("").build();
        client.execute(request);
    }
}
