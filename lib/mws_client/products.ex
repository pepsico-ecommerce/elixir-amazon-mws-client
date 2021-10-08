defmodule MWSClient.Products do
  @version "2011-10-01"
  @path "/Products/#{@version}"

  import MWSClient.Utils

  alias MWSClient.Operation

  def list_matching_products(query, opts) do
    white_list = [
      :marketplace_id,
      :query_context_id
    ]

    %{"Action" => "ListMatchingProducts", "Query" => query}
    |> add(opts, white_list)
    |> to_operation(@version, @path)
  end

  def get_matching_product(asin_list, opts) do
    %{"Action" => "GetMatchingProduct", "ASINList" => asin_list}
    |> add(opts, [:marketplace_id])
    |> restructure("ASINList", "ASIN")
    |> to_operation(@version, @path)
  end

  def get_matching_product_for_id(id_type, id_list, opts) do
    %{"Action" => "GetMatchingProductForId", "IdType" => id_type, "IdList" => id_list}
    |> add(opts, [:marketplace_id])
    |> restructure("IdList", "Id")
    |> to_operation(@version, @path)
  end

  def get_product_categories_for_asin(asin, opts) do
    %{"Action" => "GetProductCategoriesForASIN", "ASIN" => asin}
    |> add(opts, [:marketplace_id])
    |> to_operation(@version, @path)
  end

  def get_lowest_offer_listings_for_asin(asin_list, opts) do
    white_list = [
      :marketplace_id,
      :item_condition
    ]

    %{"Action" => "GetLowestOfferListingsForASIN", "ASINList" => asin_list}
    |> add(opts, white_list)
    |> restructure("ASINList", "ASIN")
    |> to_operation(@version, @path)
  end

  def get_lowest_priced_offers_for_asin(asin, opts) do
    white_list = [
      :marketplace_id,
      :item_condition
    ]

    operation =
      %{"Action" => "GetLowestPricedOffersForASIN", "ASIN" => asin, "ItemCondition" => "New"}
      |> add(opts, white_list)
      |> to_operation(@version, @path)

    %Operation{operation | method: "GET"}
  end
end
