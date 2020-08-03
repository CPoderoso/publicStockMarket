-- Table: public.stockmarket

-- DROP TABLE public.stockmarket;

CREATE TABLE public.stockmarket
(
    symbol character varying(30) COLLATE pg_catalog."default",
    bid numeric(10,4),
    ask numeric(10,4),
    adp_100 numeric(10,4),
    adp_200 numeric(10,4),
    adp_50 numeric(10,4),
    adv_21 numeric(10,0),
    cl numeric(10,4),
    datetime date,
    last numeric(10,4),
    lo numeric(10,4),
    hi numeric(10,4),
    wk52hi numeric(10,4),
    wk52lo numeric(10,4)
)

TABLESPACE pg_default;

ALTER TABLE public.stockmarket
    OWNER to postgres;

-- Table: public.optionmarket

-- DROP TABLE public.optionmarket;

CREATE TABLE public.optionmarket
(
    symbol character varying(30) COLLATE pg_catalog."default",
    bid numeric(10,4),
    ask numeric(10,4),
    idelta numeric(8,5),
    igamma numeric(8,5),
    imp_volatility numeric(8,5),
    opn numeric(10,4),
    cl numeric(10,4),
    datetime date,
    last numeric(10,4),
    lo numeric(10,4),
    hi numeric(10,4),
    put_call character(5) COLLATE pg_catalog."default",
    rootsymbol character varying(10) COLLATE pg_catalog."default",
    strikeprice numeric(10,4),
    "timestamp" numeric(12,1)
)

TABLESPACE pg_default;

ALTER TABLE public.optionmarket
    OWNER to postgres;