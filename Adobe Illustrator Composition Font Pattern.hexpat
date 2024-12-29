#pragma endian big

struct HeaderChunk {
    char tag[4];
    padding[4];
    u32 offset;
    u32 length;
};

struct CIDChunk {
    char aaa[headers.cid.length];
};

struct CFMAChunk {
    padding[6];
    u32 font_count;
    u64 expand[font_count];
    u32 size[font_count];
    u32 horizontal[font_count];
    u32 vertical[font_count];
};

struct RLBLChunk {
   padding[6];
   u32 font_count;
   u16 name_offset;
   padding[name_offset - 12]; 
   char name[headers.rlbl.length - name_offset];
};

struct NAMEChunk {
    padding[4];
    u16 offset;
    padding[offset - 6 - 2 - 2];
    u16 length_ascii;
    u16 length_unicode;
    char signature[4];  // ATC-
    char name_unicode[length_unicode - 4];
    char name_ascii[length_ascii];
};
 
struct Header {
    char id[4] [[comment("Container Signature"), name("Adobe Illustrator Composition File Header Signature")]];
    padding[8];
    
    HeaderChunk cfma;
    HeaderChunk cid;
    HeaderChunk rlbl;
    HeaderChunk name;
};

Header headers @0x00;
CIDChunk cid_chunk @$;
CFMAChunk cfma_chunk @$;
RLBLChunk rlbl_chunk @$;
NAMEChunk name_chunk @$;