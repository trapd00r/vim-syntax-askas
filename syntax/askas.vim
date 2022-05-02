"     What: askas.vim
" Language: askas
"   Author: Magnus Woldrich <m@japh.se>
"     Date: 2021-12-27

" Vim syntax file for notes over at Askas.
" :setf askas

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

" Match everything below this case sensitive.
syn case match

" Places.
syn keyword askas_where BUTIK IBUTIK ADMIN WEBBADMIN
highlight   askas_where ctermfg=215 cterm=bold

" Attention!
syn keyword askas_attention TODO FIXME NOTE REMEMBER contained
hi  link 		askas_attention Todo

" Match sql statements copied from sql software, with weird single quotes.
syn match sqlTable /\v`\zs[A-Za-z0-9_-]+\ze`/
highlight sqlTable ctermfg=179 cterm=italicbold

" Match logical AND and OR and NOT
syn match askas_conditional /[&][&]\|[|!]/
hi  link  askas_conditional Conditional

" Match URLs. Also highlight Askas funks if contained.
syn match askas_url         /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/ contains=askas_actual_funk
syn match askas_actual_funk /\vfunk\=\zs[A-Za-z0-9_-]+/ contained
highlight askas_url         ctermfg=172 cterm=bolditalic
highlight askas_actual_funk ctermfg=172 cterm=bold

" Match SPC ticket ID as well as merge request number.
syn match askas_url_spc_arende        /\vKalender_ID[=]\zs\d+/ contained
syn match askas_url_git_merge_request /\vmerge_requests\/\zs\d+/ contained
highlight askas_url_spc_arende        ctermfg=197 cterm=bold
highlight askas_url_git_merge_request ctermfg=196 cterm=bold

" Status on ticket id. \C == do not ignore case.
syn match askas_arende_status_klar /\v\CKLAR/
highlight askas_arende_status_klar ctermfg=112 cterm=bold

syn match askas_arende_status_todo /\v\CTODO/
highlight askas_arende_status_todo ctermfg=196 cterm=bold

syn match askas_arende_status_help /\v\CHELP/
highlight askas_arende_status_help ctermfg=220 cterm=bold

" Askas version number.
syn match askas_version_number /\v[|]\s*\zs\d+[.]\d+[.]\d+([.]\d+)?/
highlight askas_version_number ctermfg=220 cterm=reversebold

" Comments not-first-in-line.
syn match askas_comment_post /\v\#.+$/
hi link 	askas_comment_post Comment

" Match a perl package.
syn match askas_perl_package /\v((([A-Za-z0-9_]+)::)+([A-Za-z0-9_]+))+/
highlight askas_perl_package ctermfg=160 cterm=bold

" Match strings.
syn match askas_string /\v['"].*['"]/
hi link   askas_string String

" Custom labels:
syn match askas_label /\v[A-Za-z0-9aaöaaÖ]+:$/
highlight askas_label ctermbg=053 ctermfg=197 cterm=bold

" Comment block with data for each ticket:
" ################################################################################
" # 41942 - 2021-12-21 - Profilbild admin | 10.21.51 KLAR
" ################################################################################
" TODO askas_arende_beskr
syn match askas_comment    /\v^\s*\zs#.*\ze/ contains=askas_arende_id,askas_arende_beskr,askas_arende_status_klar,askas_version_number,askas_attention,askas_url_spc_arende,askas_url_git_merge_request,askas_file_js,askas_file_pl,askas_file_pm,askas_file_tt
hi  link  askas_comment		 Comment
syn match askas_arende_id  /\v^#[<]\s+\zs([0-9]+|INTERN)\ze/ contained
highlight askas_arende_id  ctermfg=197 cterm=bold

" For notes regarding testcases.
syn match askas_test_ok          /OK/
syn match askas_test_notok       /NOTOK/
highlight askas_test_ok          ctermfg=070 cterm=bold
highlight askas_test_notok       ctermfg=196 cterm=bold

" Match perl variables.
syn match askas_perl_var_plain "\%([@$]\|\$#\)\$*\%(\I\i*\)\=\%(\%(::\|'\)\I\i*\)*\%(::\|\i\@<=\)" contains=perlPackageRef nextgroup=perlVarMember,perlVarSimpleMember,perlMethod
highlight askas_perl_var_plain  ctermfg=010

syn match askas_line_nr /\v:\zs[0-9]+/
hi link   askas_line_nr Number

if !exists("did_notes_syntax_inits")
  let did_notes_syntax_inits = 1
endif

"hi Normal ctermfg=252 cterm=none

" Match sql things. We can include the entire sql syntax file here, but I want
" to override the case insensitivity.

syn keyword sqlSpecial FALSE NULL TRUE
hi link 		sqlSpecial Boolean

syn keyword sqlKeyword	ACCESS ADD AS ASC BEGIN BY CHECK CLUSTER COLUMN
syn keyword sqlKeyword	COMPRESS CONNECT CURRENT CURSOR DECIMAL DEFAULT DESC
syn keyword sqlKeyword	ELSE ELSIF END EXCEPTION EXCLUSIVE FILE FOR FROM
syn keyword sqlKeyword	FUNCTION GROUP HAVING IDENTIFIED IF IMMEDIATE INCREMENT
syn keyword sqlKeyword	INDEX INITIAL INTO IS LEVEL LOOP MAXEXTENTS MODE MODIFY
syn keyword sqlKeyword	NOCOMPRESS NOWAIT OF OFFLINE ON ONLINE START
syn keyword sqlKeyword	SUCCESSFUL SYNONYM TABLE THEN TO TRIGGER UID
syn keyword sqlKeyword	UNIQUE USER VALIDATE VALUES VIEW WHENEVER
syn keyword sqlKeyword	WHERE WITH OPTION ORDER PCTFREE PRIVILEGES PROCEDURE
syn keyword sqlKeyword	PUBLIC RESOURCE RETURN ROW ROWLABEL ROWNUM ROWS
syn keyword sqlKeyword	SESSION SHARE SIZE SMALLINT TYPE USING

hi link sqlKeyword Keyword

syn keyword sqlOperator	NOT AND OR
syn keyword sqlOperator	IN ANY SOME ALL BETWEEN EXISTS
syn keyword sqlOperator	LIKE ESCAPE
syn keyword sqlOperator UNION INTERSECT MINUS
syn keyword sqlOperator PRIOR DISTINCT
syn keyword sqlOperator	SYSDATE OUT

hi link sqlOperator Operator

syn keyword sqlStatement ALTER ANALYZE AUDIT COMMENT COMMIT CREATE
syn keyword sqlStatement DELETE DROP EXECUTE EXPLAIN GRANT INSERT LOCK NOAUDIT
syn keyword sqlStatement RENAME REVOKE ROLLBACK SAVEPOINT SELECT SET
syn keyword sqlStatement TRUNCATE UPDATE

hi link sqlStatement Statement

syn keyword sqlType	BOOLEAN CHAR CHARACTER DATE FLOAT INTEGER LONG
syn keyword sqlType	MLSLABEL NUMBER RAW ROWID VARCHAR VARCHAR2 VARRAY

hi link sqlType Type

hi sqlKeyword   ctermfg=081 cterm=bold
hi sqlStatement ctermfg=172 cterm=bold

" highlight files according to their LS_COLORS specification: (https://github.com/trapd00r/LS_COLORS)
" This syntax was generated by this beauty:
" =cat LS_COLORS|grep -v '^#'|grep -vP '^[#~*]'|perl -pe 'next if /\*/; s{^\.?(\S+)\s+(?:[34]8;5;(\d+))}{syn match askas_file_$1 /\\v\\C([~/]|\\.\\.?\\/).+\\.$1/\nhighlight askas_file_$1 ctermfg=$2};s{(=[0-9]+).*}{$1}'

syn match askas_file_sh       /\v\C([~/]|\.\.?\/|cgi-bin).+\.sh/
highlight askas_file_sh       ctermfg=172
syn match askas_file_css      /\v\C([~/]|\.\.?\/|cgi-bin).+\.css/
highlight askas_file_css      ctermfg=125
syn match askas_file_csv      /\v\C([~/]|\.\.?\/|cgi-bin).+\.csv/
highlight askas_file_csv      ctermfg=78
syn match askas_file_gif      /\v\C([~/]|\.\.?\/|cgi-bin).+\.gif/
highlight askas_file_gif      ctermfg=97
syn match askas_file_jpeg     /\v\C([~/]|\.\.?\/|cgi-bin).+\.jpeg/
highlight askas_file_jpeg     ctermfg=123
syn match askas_file_jpg      /\v\C([~/]|\.\.?\/|cgi-bin).+\.jpg/
highlight askas_file_jpg      ctermfg=123
syn match askas_file_JPG      /\v\C([~/]|\.\.?\/|cgi-bin).+\.JPG/
highlight askas_file_JPG      ctermfg=123
syn match askas_file_js       /\v\C([~/]|\.\.?\/|cgi-bin).+\.js/
highlight askas_file_js       ctermfg=74
syn match askas_file_jsm      /\v\C([~/]|\.\.?\/|cgi-bin).+\.jsm/
highlight askas_file_jsm      ctermfg=74
syn match askas_file_json     /\v\C([~/]|\.\.?\/|cgi-bin).+\.json/
highlight askas_file_json     ctermfg=178
syn match askas_file_jsp      /\v\C([~/]|\.\.?\/|cgi-bin).+\.jsp/
highlight askas_file_jsp      ctermfg=74
syn match askas_file_log      /\v\C([~/]|\.\.?\/|cgi-bin).+\.log/
highlight askas_file_log      ctermfg=190
syn match askas_file_markdown /\v\C([~/]|\.\.?\/|cgi-bin).+\.markdown/
highlight askas_file_markdown ctermfg=184
syn match askas_file_md       /\v\C([~/]|\.\.?\/|cgi-bin).+\.md/
highlight askas_file_md       ctermfg=184
syn match askas_file_php      /\v\C([~/]|\.\.?\/|cgi-bin).+\.php/
highlight askas_file_php      ctermfg=81
syn match askas_file_pl       /\v\C([~/]|\.\.?\/|cgi-bin).+\.pl/
highlight askas_file_pl       ctermfg=208
syn match askas_file_pm       /\v\C([~/]|\.\.?\/|cgi-bin).+\.pm/
highlight askas_file_pm       ctermfg=203
syn match askas_file_png      /\v\C([~/]|\.\.?\/|cgi-bin).+\.png/
highlight askas_file_png      ctermfg=197
syn match askas_file_sass     /\v\C([~/]|\.\.?\/|cgi-bin).+\.sass/
highlight askas_file_sass     ctermfg=125
syn match askas_file_sql      /\v\C([~/]|\.\.?\/|cgi-bin).+\.sql/
highlight askas_file_sql      ctermfg=222
syn match askas_file_sqlite   /\v\C([~/]|\.\.?\/|cgi-bin).+\.sqlite/
highlight askas_file_sqlite   ctermfg=222
syn match askas_file_svg      /\v\C([~/]|\.\.?\/|cgi-bin).+\.svg/
highlight askas_file_svg      ctermfg=97
syn match askas_file_t        /\v\C([~/]|\.\.?\/|cgi-bin).+\.t/
highlight askas_file_t        ctermfg=114
syn match askas_file_tar      /\v\C([~/]|\.\.?\/|cgi-bin).+\.tar/
highlight askas_file_tar      ctermfg=149
syn match askas_file_txt      /\v\C([~/]|\.\.?\/|cgi-bin).+\.txt/
highlight askas_file_txt      ctermfg=188
syn match askas_file_webm     /\v\C([~/]|\.\.?\/|cgi-bin).+\.webm/
highlight askas_file_webm     ctermfg=115
syn match askas_file_tt       /\v\C([~/]|\.\.?\/|cgi-bin).+\.tt/
highlight askas_file_tt       ctermfg=173
syn match askas_file_html     /\v\C([~/]|\.\.?\/|cgi-bin).+\.html?/
highlight askas_file_html     ctermfg=132
