#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <libxml/HTMLparser.h>

struct site_rec {
    char *name;
    char *url;
    char *segment;
    char *city;
    char *country;
};

static inline void dump_site_record(struct site_rec *site)
{
    printf("name: %s\n"
           "url: %s\n"
           "segment: %s\n"
           "city: %s\n"
           "country: %s\n",
           site->name,
           site->url ? site->url : "",
           site->segment ? site->segment : "",
           site->city ? site->city : "",
           site->country ? site->country : "");
}

static xmlNode *get_child_element(xmlNode *node, const char *name, int nth)
{
    int count = 0;
    xmlNode *current = NULL;

    for (current = node->children; current; current = current->next) {
        if (strcmp((char *) current->name, name))
            continue;

        count++;
        if (count == nth)
            return current;
    }

    return NULL;
}

static char *get_child_text(xmlNode *node, const char *name, int nth)
{
    int count = 0;
    xmlNode *current = NULL;

    for (current = node->children; current; current = current->next) {
        if (strcmp((char *) current->name, name))
            continue;

        count++;

        if (count == nth) {
            current = get_child_element(current, "text", 1);
            return current ? (char *) current->content : NULL;
        }
    }

    return NULL;
}

static void parse_site_record(xmlNode *node, struct site_rec *site)
{
    xmlNode *tmp = NULL;
    xmlNode *table = NULL;
    char *str = NULL;

    str = get_child_text(node, "h1", 2);
    if (str)
        site->name = str;

    table = get_child_element(node, "table", 1);

    tmp = get_child_element(table, "tr", 1);
    tmp = get_child_element(tmp, "td", 1);
    str = get_child_text(tmp, "a", 1);
    if (str)
        site->url = str;

    tmp = get_child_element(table, "tr", 2);
    str = get_child_text(tmp, "td", 1);
    if (str)
        site->segment = str;

    tmp = get_child_element(table, "tr", 3);
    str = get_child_text(tmp, "td", 1);
    if (str)
        site->city = str;

    tmp = get_child_element(table, "tr", 4);
    str = get_child_text(tmp, "td", 1);
    if (str)
        site->country = str;
}

int main(int argc, char **argv) 
{
    htmlDocPtr doc;
    int opts = 0;
    xmlNode *root = NULL;
    xmlNode *current = NULL;
    struct site_rec site = { 0, };

    if (argc != 2)  
    {
        printf("\nInvalid argument\n");
        return(1);
    }

    /* Macro to check API for match with the DLL we are using */
    LIBXML_TEST_VERSION    

    opts = HTML_PARSE_NOBLANKS | HTML_PARSE_NOERROR
          | HTML_PARSE_NOWARNING | HTML_PARSE_NONET;

    doc = htmlReadFile(argv[1], NULL, opts);
    if (doc == NULL) {
        fprintf(stderr, "Document not parsed successfully.\n");
        return 0;
    }

    root = xmlDocGetRootElement(doc);

    if (root == NULL) {
        fprintf(stderr, "empty document\n");
        xmlFreeDoc(doc);
        return 0;
    }

    current = get_child_element(root, "body", 1);
    current = get_child_element(current, "div", 2);
    current = get_child_element(current, "div", 1);
    current = get_child_element(current, "div", 1);

    parse_site_record(current, &site);

    if (site.name)
        dump_site_record(&site);

    xmlFreeDoc(doc);       // free document
    xmlCleanupParser();    // Free globals

    return 0;
}

