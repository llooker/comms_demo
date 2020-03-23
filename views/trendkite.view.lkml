view: trendkite {
  sql_table_name: misc.trendkite ;;

########### PRIMARY KEY ###########
  dimension: id {
    hidden: yes
    primary_key: yes
    sql: CONCAT(CAST(${article_raw} AS STRING), ${media_outlet}, ${title}) ;;
  }
########### DIMENSIONS ###########

  dimension_group: article {
    description: "Date the article or news was published."
    type: time
    timeframes: [
      raw,
      date,
      day_of_week,
      day_of_month,
      week,
      week_of_year,
      month,
      month_name,
      quarter,
      quarter_of_year,
      year
    ]
    sql: SAFE_CAST(${TABLE}.Date AS TIMESTAMP) ;;
  }

  dimension: ad_equivalency {
    description: "Cost for an ad of equivalent size on the publication. Designed to help PR quantify the value of an article."
    type: number
    sql: ${TABLE}.Ad_Equivalency ;;
  }

  dimension: article_impact {
    description: "High, Medium, and Low."
    type: string
    sql: ${TABLE}.Article_Impact ;;
  }

  dimension: author {
    description: "Author of the publication."
    type: string
    sql: ${TABLE}.Author ;;
  }

  dimension: city {
    description: "City of the publication."
    type: string
    sql: ${TABLE}.City ;;
  }

  dimension: country {
    description: "Country of the publication."
    type: string
    sql: ${TABLE}.Country ;;
    map_layer_name: countries
  }

  dimension: link {
    hidden: yes
    type: string
    sql: ${TABLE}.Link ;;
  }

  dimension: media_type {
    description: "Blog, News, Broadcast, etc."
    type: string
    sql: ${TABLE}.Media_Type ;;
  }

  dimension: media_outlet {
    description: "Company that published the news."
    type: string
    sql: ${TABLE}.Media_Outlet ;;
  }

  dimension: readership {
    description: "Total readership of the publication."
    type: number
    sql: ${TABLE}.Readership ;;
  }

  dimension: shares {
    description: "Number of shares if website has a social share button. "
    type: string
    sql: ${TABLE}.Shares ;;
  }

  dimension: sentiment {
    description: "Positive, Neutral, or Negative"
    type: string
    sql: ${TABLE}.Sentiment ;;
  }

  dimension: seo_impact {
    description: "Numeric scale between 1 and 100."
    type: number
    sql: ${TABLE}.SEO_Impact ;;
  }

  dimension: state {
    description: "State of the publication."
    type: string
    sql: ${TABLE}.State ;;
    map_layer_name: us_states
  }

  dimension: tags {
    description: "Tags added to the article that are added by the PR agency. Use to understand if it was a feature story or just a mention."
    type: string
    sql: ${TABLE}.Tags ;;
  }

  dimension: title {
    description: "Searchable title of the media."
    type: string
    sql: ${TABLE}.Title ;;

    link: {
      label: "Go to Article"
      url: "{{ trendkite.link._value }}"
    }
  }

########### MEASURES ###########
  measure: count {
    type: count
    drill_fields: [detail*]
  }

########### SETS ###########
  set: detail {
    fields: [
      article_date,
      media_type,
      media_outlet,
      title,
      readership,
      shares,
      ad_equivalency,
      article_impact,
      seo_impact,
      country,
      state,
      city
    ]
  }
}
