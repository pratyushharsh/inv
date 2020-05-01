class DBCreate {
  static String SQL = """
  
CREATE TABLE ITEM_CATEGORY (
    name        TEXT PRIMARY KEY NOT NULL,
    description TEXT,
    color       INTEGER
);

CREATE TABLE ITEM (
    item_id  INTEGER PRIMARY KEY  NOT NULL,
    name        TEXT,
    description TEXT,
    category TEXT DEFAULT NONE,
    price REAL DEFAULT 0.0,
    measure_required INTEGER DEFAULT 0,
    non_inventory INTEGER DEFAULT 0,
    dim_sys TEXT,
    dim_1 REAL,
    dim_2 REAL,
    dim_3 REAL,
    FOREIGN KEY(category) REFERENCES ITEM_CATEGORY(name) ON DELETE SET DEFAULT
);

CREATE TABLE ITEM_IMAGE (
    item_id INTEGER,
    sort INTEGER DEFAULT 10,
    image_url TEXT,
    FOREIGN KEY(item_id) REFERENCES ITEM(item_id) ON DELETE CASCADE
);
  
  """;
}