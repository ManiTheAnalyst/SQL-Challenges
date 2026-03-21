CREATE TABLE famous (user_id INT, follower_id INT);

INSERT INTO famous VALUES
(1, 2), (1, 3), (2, 4), (5, 1), (5, 3), 
(11, 7), (12, 8), (13, 5), (13, 10), 
(14, 12), (14, 3), (15, 14), (15, 13);


/*

A table named “famous” has two columns called user id and follower id. It represents each user ID has a particular follower ID. These follower IDs are also users of hashtag#Facebook / hashtag#Meta. Then, find the famous percentage of each user. 
Famous Percentage = number of followers a user has / total number of users on the platform.

Source: https://www.linkedin.com/posts/im-nsk_sql-activity-7263747687278088192-RsbR/

*/

select * from famous;

with distinct_users as (
  select distinct user_id from famous
  union
  select distinct follower_id from famous
), followers_count as (
  select  user_id, count(follower_id) as followers
  from famous
  group by user_id
) select f.user_id, f.followers*100.0 / (select count(*) from distinct_users) as famous_percent
from followers_count f;


/* Problem Statement
In a simple social media network, users can follow other users. You are given a table named famous where user_id represents the person being followed, and follower_id represents the person who is following them.

Write a SQL query to find all the "influencers" in the network. An influencer is defined as any user who has 2 or more followers.

Return the user_id and their total number of followers. Order the final result by user_id in ascending order.
*/

select user_id, count(follower_id) as total_number_of_followers
from famous
group by 1
having count(follower_id) >= 2
order by 1 asc;

/*Problem Statement
In this social network, most people follow someone. However, there are a few unique users who are followed by others but do not follow anyone themselves. Let's call these users "True Celebrities."

Write a SQL query to find the user_id of all True Celebrities in the network. Return the list of user_ids sorted in ascending order.

Expected Output
Based on the dataset, your query should return the following result (users 11 and 15 have followers, but their IDs never appear in the follower_id column):
*/
-- Using Left Join  on same table
select distinct f1.user_id
from famous f1
left join famous f2 on f1.user_id = f2.follower_id
where f2.follower_id is null
order by user_id asc;

/* Problem Statement
In social media analytics, a user's direct follower count is important, but their "Second-Degree Reach" shows their true viral potential. Second-degree reach is calculated by adding up all the followers that a user's followers have.

Write a SQL query to calculate the Second-Degree Reach for every user who has at least one direct follower.

If a follower does not follow anyone themselves, their contribution to the reach is 0.

Return the user_id and their second_degree_reach.

Order the results primarily by the highest second_degree_reach descending, and secondarily by user_id ascending. */

-- Calculate the direct follower count for every user
-- Join the original table to the CTE to find the followers' followers

with direct_followers as (
    select 
        user_id, 
        count(follower_id) AS follower_count
    from famous
    group by user_id
)
select 
    f.user_id,
    sum(coalesce(df.follower_count, 0)) as second_degree_reach
from famous f
left join  direct_followers df on f.follower_id = df.user_id
group by f.user_id
orderby BY second_degree_reach desc, f.user_id asc;


