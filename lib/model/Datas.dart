class Datas {
    Datas({
        required this.data,
        required this.source,
    });

    final List<Datum> data;
    final List<Source> source;

    factory Datas.fromJson(Map<String, dynamic> json){ 
        return Datas(
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
            source: json["source"] == null ? [] : List<Source>.from(json["source"]!.map((x) => Source.fromJson(x))),
        );
    }

}

class Datum {
    Datum({
        required this.idNation,
        required this.nation,
        required this.idYear,
        required this.year,
        required this.population,
        required this.slugNation,
    });

    final String? idNation;
    final String? nation;
    final int? idYear;
    final String? year;
    final int? population;
    final String? slugNation;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            idNation: json["ID Nation"],
            nation: json["Nation"],
            idYear: json["ID Year"],
            year: json["Year"],
            population: json["Population"],
            slugNation: json["Slug Nation"],
        );
    }

}

class Source {
    Source({
        required this.measures,
        required this.annotations,
        required this.name,
        required this.substitutions,
    });

    final List<String> measures;
    final Annotations? annotations;
    final String? name;
    final List<dynamic> substitutions;

    factory Source.fromJson(Map<String, dynamic> json){ 
        return Source(
            measures: json["measures"] == null ? [] : List<String>.from(json["measures"]!.map((x) => x)),
            annotations: json["annotations"] == null ? null : Annotations.fromJson(json["annotations"]),
            name: json["name"],
            substitutions: json["substitutions"] == null ? [] : List<dynamic>.from(json["substitutions"]!.map((x) => x)),
        );
    }

}

class Annotations {
    Annotations({
        required this.sourceName,
        required this.sourceDescription,
        required this.datasetName,
        required this.datasetLink,
        required this.tableId,
        required this.topic,
        required this.subtopic,
    });

    final String? sourceName;
    final String? sourceDescription;
    final String? datasetName;
    final String? datasetLink;
    final String? tableId;
    final String? topic;
    final String? subtopic;

    factory Annotations.fromJson(Map<String, dynamic> json){ 
        return Annotations(
            sourceName: json["source_name"],
            sourceDescription: json["source_description"],
            datasetName: json["dataset_name"],
            datasetLink: json["dataset_link"],
            tableId: json["table_id"],
            topic: json["topic"],
            subtopic: json["subtopic"],
        );
    }

}
