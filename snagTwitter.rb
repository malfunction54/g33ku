#!/usr/bin/ruby

require "rexml/document"
require "net/http"

include REXML

rawTwitterXML = '';

Net::HTTP.start('twitter.com', 80) { |http|
    req = Net::HTTP::Get.new('/statuses/friends_timeline.xml');
    req.basic_auth('user@domain.tld', 'password');
    response = http.request(req);
    rawTwitterXML = response.body;
}

doc = Document.new rawTwitterXML
doc.root.elements.each("/statuses/status") { |status|
    puts status.elements["user"].elements["name"].text \
    + " : " + status.elements["text"].text;
}
