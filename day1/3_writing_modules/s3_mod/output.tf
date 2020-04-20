output "out_my_bkt_name" {
  value = aws_s3_bucket.rs_bkt.bucket
}

output "out_my_bkt_versioning" {
  value = aws_s3_bucket.rs_bkt.versioning
}

output "out_bkt_arn" {
  value = aws_s3_bucket.rs_bkt.arn
}