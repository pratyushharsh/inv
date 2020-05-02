class DBCreate {


  static const String ITEM_CATEGORY = """  CREATE TABLE ITEM_CATEGORY (
    name        TEXT PRIMARY KEY NOT NULL,
    description TEXT,
    color       INTEGER
);
""";

  static const String ITEM = """ CREATE TABLE ITEM (
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
); """;

  static const String ITEM_IMAGE = """ CREATE TABLE ITEM_IMAGE (
    item_id INTEGER,
    sort INTEGER DEFAULT 10,
    image_url TEXT,
    FOREIGN KEY(item_id) REFERENCES ITEM(item_id) ON DELETE CASCADE
); """;

  static String SQL = """
PRAGMA foreign_keys = ON;
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