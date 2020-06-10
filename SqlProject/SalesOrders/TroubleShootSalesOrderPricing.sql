SELECT
        NetSuite
      FROM ITEMCODE_MAS_NS x2
      WHERE
        x2.MAS = REPLACE('/SLP-HP-WITH MAINTENANCE', '/', '')

     select 
        [Base Price]
      from Items
      where
        Items.Name = (
          SELECT
            x2.NETSUITE
          FROM ITEMCODE_MAS_NS x2
          WHERE
            x2.MAS = REPLACE('/SLP-HP-WITH MAINTENANCE', '/', '')
        )
      group by
        [Base Price]

select
 case
    -- replace the itemLine_amount with the price from NetSuite
    when exists (
      select
        [External ID]
      from Items
      where
        replace('/SLP-HP-WITH MAINTENANCE','/','') = [External Id]
    ) then (
      select
        [Base Price] -- check with Kathy about this one
      from Items
      where
        replace('/SLP-HP-WITH MAINTENANCE','/','') = [External Id]
      group by
        [Base Price]
    )
    else -1 ---sod.UnitPrice -- SO Details can't find a price, make it negative
  end AS [itemLine_amount] -- SO Details
