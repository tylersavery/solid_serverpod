CREATE TABLE IF NOT EXISTS "public"."movie" (
"id" bigint NOT NULL,
"uid" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
"title" character varying NOT NULL,
"year" numeric NOT NULL,
"image_url" "text" NOT NULL,
"created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);
ALTER TABLE "public"."movie" OWNER TO "postgres";
ALTER TABLE "public"."movie" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
SEQUENCE NAME "public"."movie_id_seq"
START WITH 1
INCREMENT BY 1
NO MINVALUE
NO MAXVALUE
CACHE 1
);
ALTER TABLE ONLY "public"."movie" ADD CONSTRAINT "movie_pkey" PRIMARY KEY ("id");