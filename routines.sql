-- -----------------------------------------------------
-- procedure mtch_by_cty_cat
-- -----------------------------------------------------

USE `exchg`;
DROP procedure IF EXISTS `exchg`.`mtch_by_cty_cat`;

DELIMITER $$
USE `exchg`$$
CREATE PROCEDURE `mtch_by_cty_cat`(in cty_id int, in cat_id int, out prc_stt json, out er_msg varchar(500))
begin
    declare cty_cnt integer;
    declare cat_cnt integer;
    declare cpy_rk integer;
    declare cpy_cde varchar(10);
    declare sprtr varchar(3);
    declare cpy_obj json;
    declare lg_dt varchar(200) default 'BaseTargeting: ';
    declare lg_obj json;
	declare mtch_obj json;
    declare lg_arr json default json_array();
    declare mtch_arr json default json_array();
    declare cpy_id_lst cursor for
        select r_k, cpy_id from cpy_lst;
    declare done integer default 0;
    declare continue handler for not found set done = 1;
	declare exit handler for sqlexception
	begin
		get diagnostics condition 1 @errno = mysql_errno, @text = message_text;
		set @err_msg = concat("ERR-", @errno, " : ", @text);
		select @err_msg into er_msg;
	end;

	open cpy_id_lst;

    loop1: loop
        fetch cpy_id_lst into cpy_rk, cpy_cde;
    
        if done = 1 then
			leave loop1;
		end if;

        select count(*) into cty_cnt from cpy_cty_lst where cty_lst_r_k = cty_id and cpy_lst_r_k = cpy_rk;
        select count(*) into cat_cnt from cpy_cat_lst where cat_lst_r_k = cat_id and cpy_lst_r_k = cpy_rk;

        if lg_dt = 'BaseTargeting: ' then
            set sprtr = '';
        else
            set sprtr = ',';
        end if;

        if cty_cnt = 0 or cat_cnt = 0 then
            set lg_dt = concat(lg_dt, sprtr,'{', cpy_cde, ', Failed}');
        else
            set lg_dt = concat(lg_dt, sprtr,'{', cpy_cde, ', Passed}');

            set cpy_obj = json_object('cpy_rk', cpy_rk, 'cpy_id', cpy_cde, 'bd_prc', null);
            set mtch_arr = json_array_append(mtch_arr, '$', cpy_obj);
        end if;

    end loop loop1;

    close cpy_id_lst;

    set mtch_obj = json_object('cpy_dt', mtch_arr, 'log_dt', lg_dt);

    set prc_stt = mtch_obj;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure bgt_bid_sff
-- -----------------------------------------------------

USE `exchg`;
DROP procedure IF EXISTS `exchg`.`bgt_bid_sff`;

DELIMITER $$
USE `exchg`$$
CREATE PROCEDURE `bgt_bid_sff`(in prs_typ varchar(15), in bid_amt decimal(5,2), in cpy_dt json, out prc_stt json, out er_msg varchar(500))
begin
    declare i integer default 0;
    declare cpy_ln integer;
    declare cpy_rw json;
    declare cpy_rk integer;
    declare cpy_cd varchar(10);
    declare sprtr varchar(3);
    declare bd_prc decimal(5,2);
    declare bd_amt decimal(5,2);
    declare avl_bgt decimal(5,2);
    declare nw_arr json default json_array();
    declare mtch_obj json;
    declare lg_dt varchar(200);
	declare exit handler for sqlexception
	begin
		get diagnostics condition 1 @errno = mysql_errno, @text = message_text;
		set @err_msg = concat("ERR-", @errno, " : ", @text);
		select @err_msg into er_msg;
	end;

    if prs_typ = 'bid' then
        set lg_dt = 'BaseBid: ';
    else
        set lg_dt = 'BudgetCheck: ';
    end if;

	set cpy_ln = json_length(cpy_dt);

    set bd_amt = bid_amt / 100;

    while i < cpy_ln do
        set cpy_rw = json_extract(cpy_dt, concat('$[',i,']'));

        set cpy_rk = json_extract(cpy_rw, '$.cpy_rk');
        set cpy_cd = trim(both '"' from json_extract(cpy_rw, '$.cpy_id'));

        if lg_dt = 'BudgetCheck: ' or lg_dt = 'BaseBid: ' then
            set sprtr = '';
        else
            set sprtr = ',';
        end if;
        
        if prs_typ = 'budget' then
            select cpy_bgt into avl_bgt from cpy_lst where r_k = cpy_rk;

            if avl_bgt >= bd_amt then
                set lg_dt = concat(lg_dt, sprtr,'{', cpy_cd, ', Passed}');
                set nw_arr = json_array_append(nw_arr, '$', cpy_rw);
            else
                set lg_dt = concat(lg_dt, sprtr,'{', cpy_cd, ', Failed}');
            end if;
        else
            select bid_prc into bd_prc from cpy_lst where r_k = cpy_rk;

            if bd_prc > bd_amt then
                set lg_dt = concat(lg_dt, sprtr,'{', cpy_cd, ', Passed}');
                set cpy_rw = json_set(cpy_rw, '$.bd_prc', bd_prc);

                set nw_arr = json_array_append(nw_arr, '$', cpy_rw);
            else
                set lg_dt = concat(lg_dt, sprtr,'{', cpy_cd, ', Failed}');
            end if;
        end if;

        set i = i + 1;
    end while;

    set mtch_obj = json_object('cpy_dt', nw_arr, 'log_dt', lg_dt);

    set prc_stt = mtch_obj;
end$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure upd_cpy_bgt
-- -----------------------------------------------------

USE `exchg`;
DROP procedure IF EXISTS `exchg`.`upd_cpy_bgt`;

DELIMITER $$
USE `exchg`$$
CREATE PROCEDURE `upd_cpy_bgt`(in cpy_rk int, in bid_amt decimal(5,2), out prc_stt int, out er_msg varchar(500))
begin
	declare exit handler for sqlexception
	begin
		get diagnostics condition 1 @errno = mysql_errno, @text = message_text;
		set @err_msg = concat("ERR-", @errno, " : ", @text);
		select @err_msg into er_msg;

        rollback;
	end;

	update cpy_lst set cpy_bgt = cpy_bgt - bid_amt where r_k = cpy_r_k;

    commit;

    set prc_stt = 1;
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_enty_id
-- -----------------------------------------------------

USE `exchg`;
DROP procedure IF EXISTS `exchg`.`get_enty_id`;

DELIMITER $$
USE `exchg`$$
CREATE PROCEDURE `get_enty_id`(in enty_typ varchar(15), in enty_vl varchar(45), out prc_stt int, out er_msg varchar(500))
begin
    declare cnt integer;
	declare exit handler for sqlexception
	begin
		get diagnostics condition 1 @errno = mysql_errno, @text = message_text;
		set @err_msg = concat("ERR-", @errno, " : ", @text);
		select @err_msg into er_msg;
	end;

	if enty_typ = 'country' then
        select count(*) into cnt from cty_lst where cty_cde = enty_vl;
        if cnt = 1 then
            select r_k into prc_stt from cty_lst where cty_cde = enty_vl;
        else
            set prc_stt = 0;
        end if;
    else
        select count(*) into cnt from cat_lst where cat_nme = enty_vl;
        if cnt = 1 then
            select r_k into prc_stt from cat_lst where cat_nme = enty_vl;
        else
            set prc_stt = 0;
        end if;
    end if;
end$$

DELIMITER ;
